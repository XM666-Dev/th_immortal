dofile("data/scripts/lib/mod_settings.lua")

local object_metatable = {
    __call = function(t, getters)
        return setmetatable(t, {
            __index = function(t, k)
                local getter = getters[k]
                if getter ~= nil then
                    return getter(t, k)
                end
            end,
        })
    end,
}
local function Object(t)
    return setmetatable(t, object_metatable)
end
---@param str string
local function parse_csv(str)
    local cellDatas = {}
    local rowHeads = {}
    local cellArrangement = {}
    local result
    local tempKey = nil
    ---设置指定行列单元格的值
    ---* 使用行列号(从1开始的数字)来作为索引
    ---* 不存在的单元格会自动新建
    ---@param row number
    ---@param column number
    local set = function(row, column, value)
        if column == 1 then
            cellDatas[value] = {}
            table.insert(cellArrangement, value)
            tempKey = value
        end
        table.insert(cellDatas[tempKey], value)
        if row == 1 then rowHeads[value] = column end
    end
    result = {
        rowHeads = rowHeads,
        cellDatas = cellDatas,
        cellArrangement = cellArrangement,
        ---获取key对应值
        ---@param row string
        ---@param column string
        ---@return string|nil
        get = function(row, column)
            -- 尝试转为数字索引
            column = rowHeads[column]
            row = cellDatas[row]
            if column and row then
                local result = row[column]                                                              -- 34为"符号
                if string.byte(result, 1, 1) == 34 and string.byte(result, #result, #result) == 34 then --删除开头和结尾的" 因为实际游戏中也不存在
                    return string.sub(result, 2, string.len(result) - 1)
                end
                return result
            else
                return nil
            end
        end,
        tostring = function()
            local cache = {}
            local newRowHeads = {}
            for v, k in pairs(rowHeads) do
                newRowHeads[k] = v
            end
            local rowHeadSize = #newRowHeads

            for i = 1, rowHeadSize do
                if newRowHeads[i] ~= "" then
                    table.insert(cache, newRowHeads[i])
                end
                if i ~= rowHeadSize then
                    table.insert(cache, ",")
                end
            end
            local cellSize = #cellArrangement
            for i = 1, cellSize do
                local key = cellArrangement[i]
                local value = cellDatas[key]
                local size = #value
                for v_i, vstr in pairs(value) do  --解析数组
                    if vstr ~= "" then
                        table.insert(cache, vstr) --插入字符串
                    end
                    if v_i ~= size then           --防止最后一个插入,
                        table.insert(cache, ",")
                    end
                end
                if i ~= cellSize then         --防止最后一个插入\n
                    table.insert(cache, "\n") --插入换行符
                end
            end
            return table.concat(cache)
        end,
    }
    local state_quotationMark = false -- 双引号状态机
    local usub = string.sub
    local codepoint = string.byte
    local StartPos = 1 --用于记录一个需要被剪切的字符串的起始位
    local charNum = 0
    local posRow = 1
    local posColumn = 1
    for i = 1, #str do
        charNum = codepoint(str, i, i)
        if state_quotationMark then               -- 处于双引号包裹中
            state_quotationMark = (charNum ~= 34) --减少分支优化
            if charNum == 92 then                 --转义符考虑
                i = i + 1                         --当前字符是转义符，下一个字符也应该跳过，所以加1，下一次循环再加1
            end
        else
            if charNum == 34 then                                  -- 34为"符号
                state_quotationMark = true                         -- 进入双引号包裹
            elseif charNum == 44 then                              -- 分隔符为en逗号 44为,
                set(posRow, posColumn, usub(str, StartPos, i - 1)) --i-1是为了不要把,加进去
                StartPos = i + 1                                   --重设起始位
                posColumn = posColumn + 1
            elseif charNum == 10 then                              --10为\n
                -- 对连续换行(空行)和"\n"(Windows换行符)特殊处理
                if (codepoint(str, i - 1, i - 1) ~= 10) then
                    set(posRow, posColumn, usub(str, StartPos, i - 1))
                    StartPos = i + 1
                    posRow = posRow + 1
                    posColumn = 1
                end
            end
        end
    end
    set(posRow, posColumn, usub(str, StartPos, #str - 1))
    return result
end
local translations = parse_csv([[
,en,ru,pt-br,es-es,de,fr-fr,it,pl,zh-cn,jp,ko,,NOTES – use \n for newline,max length,,,,,,,,,,
th_immortal.item_power,Power,,,,,,,,火力,,,,,,,,,,,,,,,
th_immortal.log_powerup,Power up!,,,,,,,,火力提升！,,,,,,,,,,,,,,,
th_immortal.hud_power,Power: $0,,,,,,,,火力：$0,,,,,,,,,,,,,,,
th_immortal.action_kami,Kami,,,,,,,,符札,,,,,,,,,,,,,,,
th_immortal.actiondesc_kami,Sacredness,,,,,,,,神圣之物,,,,,,,,,,,,,,,
th_immortal.action_kami_trigger,Kami with trigger,,,,,,,,带有触发的符札,,,,,,,,,,,,,,,
th_immortal.actiondesc_kami_trigger,Sacredness that casts another spell upon collision,,,,,,,,在碰撞时施放另一法术的神圣之物,,,,,,,,,,,,,,,
th_immortal.action_kami_homing,Homing kami,,,,,,,,追踪符札,,,,,,,,,,,,,,,
th_immortal.actiondesc_kami_homing,Forcefully,,,,,,,,指向性,,,,,,,,,,,,,,,
th_immortal.action_orb_small,Small orb,,,,,,,,小玉,,,,,,,,,,,,,,,
th_immortal.actiondesc_orb_small,A standard shot,,,,,,,,标准射击,,,,,,,,,,,,,,,
th_immortal.action_orb_medium,Medium orb,,,,,,,,中玉,,,,,,,,,,,,,,,
th_immortal.actiondesc_orb_medium,A larger shot,,,,,,,,更大的射击,,,,,,,,,,,,,,,
th_immortal.action_orb_large,Large orb,,,,,,,,大玉,,,,,,,,,,,,,,,
th_immortal.actiondesc_orb_large,A powerful large shot,,,,,,,,强力的巨型射击,,,,,,,,,,,,,,,
th_immortal.item_gohei,Gohei,,,,,,,,御币,,,,,,,,,,,,,,,
th_immortal.item_jade,Jade,,,,,,,,阴阳玉,,,,,,,,,,,,,,,
th_immortal.itemdesc_jade,Mysterious stuff,,,,,,,,神秘之物,,,,,,,,,,,,,,,
th_immortal.item_narcissus,Narcissus,,,,,,,,水仙花,,,,,,,,,,,,,,,
th_immortal.item_pistol,Pistol lunar,,,,,,,,月面手枪,,,,,,,,,,,,,,,
th_immortal.item_saisen,Saisen,,,,,,,,赛钱箱,,,,,,,,,,,,,,,
th_immortal.itemdesc_saisen,Drop some gold into the offertory box... Mysterious forces might reward generosity.,,,,,,,,丢些金子到赛钱箱里吧... 神秘的力量或许会奖赏慷慨之举,,,,,,,,,,,,,,,
th_immortal.itempickup_pay,Press $0 to pay '$1',,,,,,,,按 $0 支付“$1”,,,,,,,,,,,,,,,
th_immortal.itempickup_notenoughgold,Not enough gold to pay '$0',,,,,,,,黄金不足以支付“$0”,,,,,,,,,,,,,,,
]])
local function get_language()
    return ({
        ["English"] = "en",
        ["русский"] = "ru",
        ["Português (Brasil)"] = "pt-br",
        ["Español"] = "es-es",
        ["Deutsch"] = "de",
        ["Français"] = "fr-fr",
        ["Italiano"] = "it",
        ["Polska"] = "pl",
        ["简体中文"] = "zh-cn",
        ["日本語"] = "jp",
        ["한국어"] = "ko",
    })[GameTextGet("$current_language")]
end
local function get_text(key)
    local text = translations.get(key, get_language())
    return text ~= "" and text or translations.get(key, "en")
end

local mod_id = "th_immortal"
mod_settings_version = 1
mod_settings =
{
    Object{
        id = "miss_sound",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    }{
            ui_name = function() return get_text("th_immortal.setting_misssound") end,
            ui_description = function() return get_text("th_immortal.settingdesc_misssound") end,
        },
}

function ModSettingsUpdate(init_scope)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end

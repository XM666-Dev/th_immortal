dofile_once("mods/th_immortal/files/lib/environment.lua")
dofile_once("mods/th_immortal/files/lib/utilities.lua")
local nxml = dofile_once("mods/th_immortal/files/lib/nxml.lua")

local biome_xmls = {}
local biome_scripts = {}

local dummy = function() end
local raw_death = death
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local raw_do_money_drop = do_money_drop
    do_money_drop = function(amount_multiplier, trick_kill)
        raw_do_money_drop(amount_multiplier, trick_kill)
        if not IsPlayer(entity_thats_responsible) or Player(entity_thats_responsible).power < 256 then
            local this = GetUpdatedEntityID()
            local x, y = EntityGetTransform(this)
            local filename = EntityGetFilename(this)

            local biome_filename = DebugBiomeMapGetFilename(x, y)
            local biome_xml = biome_xmls[biome_filename] or nxml.parse_file(biome_filename)
            biome_xmls[biome_filename] = biome_xml

            local topology = biome_xml:first_of("Topology")
            if topology ~= nil and topology.attr.lua_script ~= nil then
                local biome_script = biome_scripts[topology.attr.lua_script]
                if biome_script == nil then
                    local __loadonce = {}
                    local __loaded = {}
                    biome_script = setmetatable({
                        RegisterSpawnFunction = dummy,
                        dofile_once = function(filename)
                            local result = nil
                            local cached = __loadonce[filename]
                            if cached ~= nil then
                                result = cached[1]
                            else
                                local f, err = loadfile(filename)
                                if f == nil then return f, err end
                                result = f()
                                __loadonce[filename] = {result}
                                do_mod_appends(filename)
                            end
                            return result
                        end,
                        dofile = function(filename)
                            local f = __loaded[filename]
                            if f == nil then
                                f, err = loadfile(filename)
                                if f == nil then return f, err end
                                __loaded[filename] = f
                            end
                            local result = f()
                            do_mod_appends(filename)
                            return result
                        end,
                    }, {__index = _G})
                    biome_scripts[topology.attr.lua_script] = biome_script
                    local env = getfenv(0)
                    setfenv(0, biome_script)
                    biome_script.dofile(topology.attr.lua_script)
                    setfenv(0, env)
                end

                local groups = {{"g_small_enemies", 0.33}, {"g_big_enemies", 0.5}, {"g_unique_enemy", 0.66}, {"g_unique_enemy2", 0.75}, {"g_unique_enemy3", 1}, {"g_fungi", 0.5}}
                local current_group = nil
                local found = false
                for i, group in ipairs(groups) do
                    local key = group[1]
                    for i, enemy in ipairs(biome_script[key] or {}) do
                        if enemy.entity == filename or type(enemy.entity) == "table" and table.find(enemy.entity, filename) then
                            current_group = group
                            found = true
                            break
                        end
                    end
                    if found then
                        break
                    end
                end
                if current_group ~= nil then
                    local chance = current_group[2]
                    SetRandomSeed(x, y)
                    if Random() < chance then
                        for i = 1, amount_multiplier do
                            EntityLoad("mods/th_immortal/files/items/power/power.xml", x, y)
                        end
                    end
                end
            end
        end
    end
    raw_death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    do_money_drop = raw_do_money_drop
end

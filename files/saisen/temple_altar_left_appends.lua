dofile_once("mods/th_immortal/files/lib/environment.lua")
dofile_once("mods/th_immortal/files/lib/utilities.lua")

local raw_spawn_statue = spawn_statue
function spawn_statue(x, y)
    raw_spawn_statue(x, y)
    if mod.saisen_count > 0 or Random() < 0.5 then
        x = x + 48
        local saisen = EntityLoad("mods/th_immortal/files/saisen/saisen.xml", x, y)
        local saisen_object = Saisen(saisen)
        local actions = ""
        local hm_visits = tonumber(GlobalsGetValue("HOLY_MOUNTAIN_VISITS", "0"))
        for i = 1, hm_visits + 2 do
            actions = actions .. GetRandomAction(x, y, math.min(hm_visits + 2, 7), i) .. ","
        end
        if mod.gohei_picked then
            actions = actions .. "TH_IMMORTAL_KAMI,"
        end
        saisen_object.actions = actions
        saisen_object.cost_multiplier = hm_visits
    end
end

dofile_once("mods/th_immortal/files/lib/utilities.lua")

function item_pickup(entity_item, entity_pickupper, item_name)
    if IsPlayer(entity_pickupper) then
        mod.gohei_picked = true
    end
end

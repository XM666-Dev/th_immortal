dofile_once("mods/th_immortal/files/lib/utilities.lua")

function item_pickup(item, pickupper)
    local pickupper_object = Player(pickupper)
    pickupper_object.power = math.min(pickupper_object.power + 1, 256)
    GamePlaySound("mods/th_immortal/files/audio/th.bank", "event_cues/power/create", nil, nil)
    EntityKill(item)
end

dofile_once("mods/th_immortal/files/lib/utilities.lua")

local immune_frame = 0
function damage_received(damage, message, responsible, fatal, projectile_responsible)
    local this = GetUpdatedEntityID()
    if responsible ~= this and damage > 0 and (validate(responsible) ~= nil or validate(projectile_responsible) ~= nil) then
        local damage_frame = GameGetFrameNum()
        if damage_frame < immune_frame then
            return
        end
        immune_frame = damage_frame + 180
        local reduce_amount = 8
        local this_object = Player(this)
        if this_object.power > 128 then
            reduce_amount = math.max((this_object.power - 128) / 2, reduce_amount)
        end
        this_object.power = math.max(this_object.power - reduce_amount, 0)
        if ModSettingGet("th_immortal.miss_sound") then
            GamePlaySound("mods/th_immortal/files/audio/th.bank", "event_cues/dead/create", nil, nil)
        end
    end
end

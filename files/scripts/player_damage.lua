dofile_once("mods/th_immortal/files/lib/utilities.lua")

local prev_damage_frame = 0
function damage_received(damage, message, responsible, fatal, projectile_responsible)
    local this = GetUpdatedEntityID()
    if responsible ~= this and (validate(responsible) ~= nil or validate(projectile_responsible) ~= nil) then
        local this_object = Player(this)
        local damage_frame = GameGetFrameNum()
        if damage_frame < prev_damage_frame + 180 then
            return
        elseif damage_frame < prev_damage_frame + 360 then
            this_object.power = math.max(0, this_object.power - 1)
        elseif damage_frame < prev_damage_frame + 540 then
            this_object.power = math.max(0, this_object.power - 2)
        elseif damage_frame < prev_damage_frame + 720 then
            this_object.power = math.max(0, this_object.power - 3)
        else
            this_object.power = math.max(0, this_object.power - 4)
        end
        GamePlaySound("mods/th_immortal/files/audio/th.bank", "event_cues/dead/create", nil, nil)
        prev_damage_frame = damage_frame
    end
end

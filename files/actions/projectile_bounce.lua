local this = GetUpdatedEntityID()
local velocity_x, velocity_y = GameGetVelocityCompVelocity(this)
if velocity_x == 0 and velocity_y == 0 then
    local veloctiy = EntityGetFirstComponent(this, "VelocityComponent")
    if veloctiy ~= nil then
        local prev_velocity_x, prev_velocity_y = GetValueNumber("prev_velocity_x", 0), GetValueNumber("prev_velocity_y", 0)
        local x, y = EntityGetTransform(this)
        EntitySetTransform(this, x, y, math.atan2(prev_velocity_y, prev_velocity_x))
    end
else
    SetValueNumber("prev_velocity_x", velocity_x)
    SetValueNumber("prev_velocity_y", velocity_y)
end

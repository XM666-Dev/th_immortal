local this = GetUpdatedEntityID()
local velocity = EntityGetFirstComponent(this, "VelocityComponent")
if velocity ~= nil then
    ComponentSetValue2(velocity, "gravity_y", ComponentGetValue2(velocity, "gravity_y") / 6)
    ComponentSetValue2(velocity, "air_friction", math.min(0, ComponentGetValue2(velocity, "air_friction")))
    ComponentSetValue2(velocity, "terminal_velocity", math.max(2000, ComponentGetValue2(velocity, "terminal_velocity")))
end
local projectile = EntityGetFirstComponent(this, "ProjectileComponent")
if projectile ~= nil then
    local shooter = ComponentGetValue2(projectile, "mWhoShot")
    EntityAddComponent2(shooter, "LuaComponent", {script_shot = "mods/th_immortal/files/pistol/pure.lua", remove_after_executed = true})
end

local this = GetUpdatedEntityID()
local lance = EntityGetFilename(this):find("lance.xml$")
local velocity = EntityGetFirstComponent(this, "VelocityComponent")
if velocity ~= nil then
    ComponentSetValue2(velocity, "liquid_drag", 0)
    ComponentSetValue2(velocity, "liquid_death_threshold", 0)
    if lance then
        ComponentSetValue2(velocity, "liquid_drag", -1)
        ComponentSetValue2(velocity, "apply_terminal_velocity", false)
        ComponentSetValue2(velocity, "gravity_y", 0)
    end
end
local projectile = EntityGetFirstComponent(this, "ProjectileComponent")
if projectile ~= nil then
    ComponentSetValue2(projectile, "die_on_liquid_collision", false)
    if lance then
        ComponentSetValue2(projectile, "lifetime", 3)
        ComponentSetValue2(projectile, "speed_min", ComponentGetValue2(projectile, "speed_min") * 2.5)
        ComponentSetValue2(projectile, "speed_max", ComponentGetValue2(projectile, "speed_max") * 2.5)
        ComponentSetValue2(projectile, "friendly_fire", false)
    end
end

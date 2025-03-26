local this = GetUpdatedEntityID()
local lance = EntityGetFilename(this):find("lance.xml$")
local velocity = EntityGetFirstComponent(this, "VelocityComponent")
if velocity ~= nil then
    ComponentSetValue2(velocity, "liquid_drag", 0)
    ComponentSetValue2(velocity, "liquid_death_threshold", 0)
    if lance then
        ComponentSetValue2(velocity, "liquid_drag", -1)
        ComponentSetValue2(velocity, "gravity_y", 0)
    end
end
local projectile = EntityGetFirstComponent(this, "ProjectileComponent")
if projectile ~= nil then
    ComponentSetValue2(projectile, "die_on_liquid_collision", false)
    if lance then
        ComponentSetValue2(projectile, "lifetime", 3)
        local speed = 900
        ComponentSetValue2(projectile, "speed_min", speed)
        ComponentSetValue2(projectile, "speed_max", speed)
        ComponentSetValue2(projectile, "mInitialSpeed", speed)
        ComponentSetValue2(projectile, "damage_scaled_by_speed", true)
        ComponentSetValue2(projectile, "knockback_force", 0)
        ComponentSetValue2(projectile, "damage_game_effect_entities", ComponentGetValue2(projectile, "damage_game_effect_entities") .. "mods/th_immortal/files/narcissus/effect_stun.xml,")
        ComponentSetValue2(projectile, "friendly_fire", false)
    end
end
if lance then
    EntityAddComponent2(this, "GameAreaEffectComponent", {radius = 8})
end

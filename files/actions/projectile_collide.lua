dofile_once("mods/th_immortal/files/lib/utilities.lua")

local this = GetUpdatedEntityID()
local velocity_x, velocity_y = GameGetVelocityCompVelocity(this)
velocity_x, velocity_y = vec_mult(velocity_x, velocity_y, 0.01666666666666667)
local x, y = EntityGetTransform(this)
local hit, hit_x, hit_y = RaytracePlatforms(x - velocity_x, y - velocity_y, x, y)
local projectile = EntityGetFirstComponent(this, "ProjectileComponent")
if projectile ~= nil and hit then
    ComponentSetValue2(projectile, "collide_with_world", true)
    EntitySetTransform(this, hit_x, hit_y)
end

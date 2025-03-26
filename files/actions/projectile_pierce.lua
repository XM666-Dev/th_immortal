dofile_once("mods/th_immortal/files/lib/utilities.lua")

local this = GetUpdatedEntityID()
local this_object = Projectile(this)
local projectile = EntityGetFirstComponent(this, "ProjectileComponent")
if projectile ~= nil then
    local frame_damaged = ComponentGetValue2(projectile, "mLastFrameDamaged")
    if frame_damaged ~= GetValueInteger("frame_damaged", -1024) then
        SetValueInteger("frame_damaged", frame_damaged)
        local damaged_entities = ComponentGetValue2(projectile, "mDamagedEntities")
        this_object.pierce_count = this_object.pierce_count - #damaged_entities
        if this_object.pierce_count <= 0 then
            ComponentSetValue2(projectile, "penetrate_entities", false)
        end
    end
end

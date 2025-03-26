dofile_once("mods/th_immortal/files/lib/utilities.lua")

local this = GetUpdatedEntityID()
local x, y, rotation, scale_x, scale_y = EntityGetTransform(this)
for i, kami in ipairs(EntityGetAllChildren(this, "th_immortal.kami") or {}) do
    EntitySetComponentsWithTagEnabled(kami, "enabled_in_world", true)
    local inherit = EntityGetFirstComponent(kami, "InheritTransformComponent")
    if inherit ~= nil then
        local pos_x, pos_y = ComponentGetValue2(inherit, "Transform")
        pos_x, pos_y = vec_scale(pos_x, pos_y, scale_x, scale_y)
        pos_x, pos_y = vec_rotate(pos_x, pos_y, rotation)
        pos_x, pos_y = vec_add(pos_x, pos_y, x, y)
        EntitySetTransform(kami, pos_x, pos_y)
    end
end

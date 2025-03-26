local this = GetUpdatedEntityID()
local sprite = EntityGetFirstComponent(this, "SpriteComponent")
if sprite ~= nil then
    ComponentSetValue2(sprite, "image_file", "mods/th_immortal/files/narcissus/narcissus.png")
end

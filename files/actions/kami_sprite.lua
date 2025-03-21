local sprite = EntityGetFirstComponent(GetUpdatedEntityID(), "SpriteComponent")
if sprite ~= nil then
    ComponentSetValue2(sprite, "image_file", "mods/th_immortal/files/actions/kami.png")
end

function electricity_receiver_electrified()
    for i, kami in ipairs(EntityGetWithTag("th_immortal.projectile_kami")) do
        local sprite = EntityGetFirstComponent(kami, "SpriteComponent")
        if sprite ~= nil then
            ComponentSetValue2(sprite, "image_file", "mods/th_immortal/files/actions/kami_gfx.png")
            EntityRefreshSprite(kami, sprite)
        end
    end
end

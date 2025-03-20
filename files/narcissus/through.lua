function electricity_receiver_electrified()
    for i, ragdoll in ipairs(EntityGetWithTag("th_immortal.ragdoll")) do
        local x, y = EntityGetTransform(ragdoll)
        for i, projectile in ipairs(EntityGetInRadiusWithTag(x, y, 32, "projectile")) do
            local projectile = EntityGetFirstComponent(projectile, "ProjectileComponent")
            if projectile ~= nil and ComponentGetValue2(projectile, "go_through_this_material") == "" then
                ComponentSetValue2(projectile, "go_through_this_material", "meat_done")
            end
        end
    end
end

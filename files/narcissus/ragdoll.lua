local images = {}
function death()
    local this = GetUpdatedEntityID()
    local damage_model = EntityGetFirstComponent(this, "DamageModelComponent")
    if damage_model ~= nil then
        for i, entity in ipairs(EntityGetInRadius(0, 0, math.huge)) do
            if EntityGetComponentIncludingDisabled(entity, "ItemComponent") ~= nil then
                for i, sprite in ipairs(EntityGetComponentIncludingDisabled(entity, "SpriteComponent") or {}) do
                    local image_file = ComponentGetValue2(sprite, "image_file")
                    if not image_file:find(".xml$") then
                        local find = true
                        for i, image in ipairs(images) do
                            if image == image_file then
                                find = false
                                break
                            end
                        end
                        if find then
                            table.insert(images, image_file)
                        end
                    end
                end
            end
        end
        local image = images[ProceduralRandomi(GameGetFrameNum(), 0, 1, #images)]
        local ragdoll = "mods/th_immortal/files/ragdolls/" .. image .. ".txt"
        ModTextFileSetContent(ragdoll, image)
        ComponentSetValue2(damage_model, "ragdoll_filenames_file", ragdoll)
        ComponentSetValue2(damage_model, "ragdoll_material", "meat_done")
    end
end

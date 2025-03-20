local this = GetUpdatedEntityID()
for i, cloth in ipairs(EntityGetAllChildren(this, "th_immortal.cloth") or {}) do
    EntitySetComponentsWithTagEnabled(cloth, "enabled_in_world", true)
end

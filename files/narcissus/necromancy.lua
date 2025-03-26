dofile_once("mods/th_immortal/files/lib/utilities.lua")
dofile_once("data/scripts/gun/gun_actions.lua")

local this = GetUpdatedEntityID()
local damage_model = EntityGetFirstComponent(this, "DamageModelComponent")
if damage_model ~= nil then
    local sprite = actions[ProceduralRandomi(GameGetFrameNum(), 0, 1, #actions)].sprite
    local ragdoll = "mods/th_immortal/files/ragdolls/" .. sprite .. ".txt"
    ModTextFileSetContent(ragdoll, sprite)
    ComponentSetValue2(damage_model, "ragdoll_filenames_file", ragdoll)
    ComponentSetValue2(damage_model, "ragdoll_material", "meat_done")
end
remove_component(get_variable_storage_component(this, "projectile_who_shot"))

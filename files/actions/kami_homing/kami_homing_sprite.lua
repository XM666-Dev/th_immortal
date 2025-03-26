local this = GetUpdatedEntityID()
local sprite = EntityLoad("mods/th_immortal/files/actions/kami_homing/kami_homing_sprite.xml")
EntitySetTransform(sprite, EntityGetTransform(this))

local this = GetUpdatedEntityID()
local parent = EntityGetParent(this)
local character_platforming = EntityGetFirstComponent(parent, "CharacterPlatformingComponent")
if character_platforming ~= nil and not ComponentGetValue2(character_platforming, "mIsPrecisionJumping") then
    ComponentSetValue2(character_platforming, "mIsPrecisionJumping", true)
    ComponentSetValue2(character_platforming, "mPrecisionJumpingSpeedX", 0)
end

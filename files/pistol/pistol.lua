local this = GetUpdatedEntityID()
local ability = EntityGetFirstComponentIncludingDisabled(this, "AbilityComponent")
if ability ~= nil then
    local mana = ComponentGetValue2(ability, "mana")
    local mana_max = ComponentGetValue2(ability, "mana_max")
    if mana < mana_max then
        ComponentSetValue2(ability, "mana", math.min(mana + ComponentGetValue2(ability, "mana_charge_speed") / 60, mana_max))
    end
end

local raw_do_money_drop = do_money_drop
function do_money_drop(amount_multiplier, trick_kill)
    raw_do_money_drop(amount_multiplier, trick_kill)
    if Random() < 0.5 then
        local this = GetUpdatedEntityID()
        local x, y = EntityGetTransform(this)
        for i = 1, amount_multiplier do
            EntityLoad("mods/th_immortal/files/items/power/power.xml", x, y)
        end
    end
end

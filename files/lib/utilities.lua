dofile_once("mods/th_immortal/files/lib/tactic.lua")

mod = Entity{
    saisen_count = VariableField("th_immortal.saisen_count", "value_int"),
    gohei_picked = VariableField("th_immortal.gohei_picked", "value_bool"),
} (1)

Saisen = Entity{
    pay_count = VariableField("th_immortal.pay_count", "value_int"),
    contents = VariableField("th_immortal.contents", "value_string"),
    actions = VariableField("th_immortal.actions", "value_string"),
    cost_multiplier = VariableField("th_immortal.cost_multiplier", "value_float", 1),
}

Player = Entity{
    power = VariableField("th_immortal.power", "value_int"),
    script_damage = ComponentField{"LuaComponent", "th_immortal.script_damage", _tags = "th_immortal.script_damage", script_damage_received = "mods/th_immortal/files/scripts/player_damage.lua"},
}

Projectile = Entity{
    pierce_count = VariableField("th_immortal.pierce_count", "value_int"),
}

TIER_1 = 16
TIER_2 = 48
TIER_3 = 128

function get_tier(power)
    if power < TIER_1 then
        return 0
    elseif power < TIER_2 then
        return 1
    elseif power < TIER_3 then
        return 2
    end
    return 3
end

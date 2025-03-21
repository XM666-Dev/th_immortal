dofile_once("mods/th_immortal/files/tactic.lua")

mod = Entity{
    saisen_count = VariableField("th_immortal.saisen_count", "value_int"),
} (1)

Saisen = Entity{
    pay_count = VariableField("th_immortal.pay_count", "value_int"),
    contents = VariableField("th_immortal.contents", "value_string"),
    actions = VariableField("th_immortal.actions", "value_string"),
    cost_multiplier = VariableField("th_immortal.cost_multiplier", "value_float", 1),
}

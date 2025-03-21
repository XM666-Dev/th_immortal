local function insert_actions(...)
    for i = 1, select("#", ...) do
        local action = select(i, ...)
        table.insert(actions, action)
    end
end

insert_actions(
    {
        id                  = "TH_IMMORTAL_KAMI",
        name                = "Kami",
        description         = "Sacredness",
        spawn_requires_flag = "action_th_immortal_kami",
        sprite              = "mods/th_immortal/files/actions/kami_gfx.png",
        related_projectiles = {"mods/th_immortal/files/actions/kami.xml"},
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2",
        spawn_probability   = "1,0.5,0.25",
        price               = 200,
        mana                = 1,
        action              = function()
            add_projectile("mods/th_immortal/files/actions/kami.xml")
            c.damage_curse_add = c.damage_curse_add + 0.04
        end,
    }
)

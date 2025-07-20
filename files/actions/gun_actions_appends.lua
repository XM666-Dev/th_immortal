dofile_once("mods/th_immortal/files/lib/environment.lua")
dofile_once("mods/th_immortal/files/lib/utilities.lua")

local function insert(...)
    table.insert(actions, ...)
    return insert
end
insert
{
    id                  = "TH_IMMORTAL_KAMI",
    name                = "$th_immortal.action_kami",
    description         = "$th_immortal.actiondesc_kami",
    spawn_requires_flag = "action_th_immortal_kami",
    sprite              = "mods/th_immortal/files/actions/kami/kami_ui.png",
    related_projectiles = {"mods/th_immortal/files/actions/kami/kami.xml"},
    type                = ACTION_TYPE_PROJECTILE,
    spawn_level         = "0,1,2",
    spawn_probability   = "1,0.5,0.25",
    price               = 200,
    mana                = 1,
    action              = function()
        add_projectile("mods/th_immortal/files/actions/kami/kami.xml")
        local caster = GetUpdatedEntityID()
        local caster_object = Player(caster)
        if caster_object.power >= TIER_1 then
            add_projectile("mods/th_immortal/files/actions/kami/kami_multi.xml")
        end
        if caster_object.power >= TIER_2 then
            add_projectile("mods/th_immortal/files/actions/kami/kami_multi.xml")
        end
        if caster_object.power >= TIER_3 then
            add_projectile("mods/th_immortal/files/actions/kami/kami_multi.xml")
        end
        c.damage_curse_add = c.damage_curse_add + 0.04
    end,
}
    {
        id                  = "TH_IMMORTAL_KAMI_TRIGGER",
        name                = "$th_immortal.action_kami_trigger",
        description         = "$th_immortal.actiondesc_kami_trigger",
        spawn_requires_flag = "action_th_immortal_kami",
        sprite              = "mods/th_immortal/files/actions/kami/kami_trigger_ui.png",
        related_projectiles = {"mods/th_immortal/files/actions/kami/kami.xml"},
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3",
        spawn_probability   = "0.5,0.25,0.25,0.25",
        price               = 250,
        mana                = 5,
        action              = function()
            add_projectile_trigger_hit_world("mods/th_immortal/files/actions/kami/kami.xml", 1)
            local caster = GetUpdatedEntityID()
            local caster_object = Player(caster)
            if caster_object.power >= TIER_1 then
                add_projectile_trigger_hit_world("mods/th_immortal/files/actions/kami/kami_multi.xml", 1)
            end
            if caster_object.power >= TIER_2 then
                add_projectile_trigger_hit_world("mods/th_immortal/files/actions/kami/kami_multi.xml", 1)
            end
            if caster_object.power >= TIER_3 then
                add_projectile_trigger_hit_world("mods/th_immortal/files/actions/kami/kami_multi.xml", 1)
            end
            c.damage_curse_add = c.damage_curse_add + 0.04
        end,
    }
    {
        id                  = "TH_IMMORTAL_KAMI_HOMING",
        name                = "$th_immortal.action_kami_homing",
        description         = "$th_immortal.actiondesc_kami_homing",
        spawn_requires_flag = "action_th_immortal_kami",
        sprite              = "mods/th_immortal/files/actions/kami_homing/kami_homing_ui.png",
        related_projectiles = {"mods/th_immortal/files/actions/kami_homing/kami_homing.xml"},
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "2,3,5,6,10",
        spawn_probability   = "0.5,0.25,0.5,0.5,0.1",
        price               = 250,
        mana                = 10,
        action              = function()
            add_projectile("mods/th_immortal/files/actions/kami_homing/kami_homing.xml")
            local caster = GetUpdatedEntityID()
            local caster_object = Player(caster)
            if caster_object.power >= TIER_1 then
                add_projectile("mods/th_immortal/files/actions/kami_homing/kami_homing_multi.xml")
            end
            if caster_object.power >= TIER_2 then
                add_projectile("mods/th_immortal/files/actions/kami_homing/kami_homing_multi.xml")
            end
            if caster_object.power >= TIER_3 then
                add_projectile("mods/th_immortal/files/actions/kami_homing/kami_homing_multi.xml")
            end
            c.damage_curse_add = c.damage_curse_add + 0.04
        end,
    }
    {
        id                  = "TH_IMMORTAL_ORB_SMALL",
        name                = "$th_immortal.action_orb_small",
        description         = "$th_immortal.actiondesc_orb_small",
        sprite              = "mods/th_immortal/files/actions/orb_small/orb_small.png",
        related_projectiles = {"mods/th_immortal/files/actions/orb_small/orb_small.xml"},
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "0,1,2,3",
        spawn_probability   = "1,1,1,0.5",
        price               = 150,
        mana                = 1,
        action              = function()
            add_projectile("mods/th_immortal/files/actions/orb_small/orb_small.xml")
            local caster = GetUpdatedEntityID()
            local caster_object = Player(caster)
            if caster_object.power >= TIER_1 then
                c.pattern_degrees = c.pattern_degrees + 5
                add_projectile("mods/th_immortal/files/actions/orb_small/orb_small.xml")
                add_projectile("mods/th_immortal/files/actions/orb_small/orb_small.xml")
            end
            if caster_object.power >= TIER_2 then
                c.pattern_degrees = c.pattern_degrees + 5
                add_projectile("mods/th_immortal/files/actions/orb_small/orb_small.xml")
            end
            if caster_object.power >= TIER_3 then
                c.pattern_degrees = c.pattern_degrees + 5
                add_projectile("mods/th_immortal/files/actions/orb_small/orb_small.xml")
            end
        end,
    }
    {
        id                  = "TH_IMMORTAL_ORB_MEDIUM",
        name                = "$th_immortal.action_orb_medium",
        description         = "$th_immortal.actiondesc_orb_medium",
        sprite              = "mods/th_immortal/files/actions/orb_medium/orb_medium.png",
        related_projectiles = {"mods/th_immortal/files/actions/orb_medium/orb_medium.xml"},
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "2,3,4,5",
        spawn_probability   = "1,1,1,0.5",
        price               = 250,
        mana                = 10,
        action              = function()
            add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
            local caster = GetUpdatedEntityID()
            local caster_object = Player(caster)
            if caster_object.power >= TIER_1 then
                c.pattern_degrees = c.pattern_degrees + 180
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
            end
            if caster_object.power >= TIER_2 then
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
            end
            if caster_object.power >= TIER_3 then
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
                add_projectile("mods/th_immortal/files/actions/orb_medium/orb_medium.xml")
            end
            c.fire_rate_wait = c.fire_rate_wait + 3
            c.screenshake = c.screenshake + 0.5
        end,
    }
    {
        id                  = "TH_IMMORTAL_ORB_LARGE",
        name                = "$th_immortal.action_orb_large",
        description         = "$th_immortal.actiondesc_orb_large",
        sprite              = "mods/th_immortal/files/actions/orb_large/orb_large_ui.png",
        related_projectiles = {"mods/th_immortal/files/actions/orb_large/orb_large.xml"},
        type                = ACTION_TYPE_PROJECTILE,
        spawn_level         = "3,4,5,6",
        spawn_probability   = "0.4,0.4,0.5,0.5",
        price               = 300,
        mana                = 100,
        action              = function()
            local filename = "mods/th_immortal/files/actions/orb_large/orb_large.xml"
            local caster = GetUpdatedEntityID()
            local caster_object = Player(caster)
            if caster_object.power >= TIER_1 then
                filename = "mods/th_immortal/files/actions/orb_large/orb_large_tier1.xml"
            end
            if caster_object.power >= TIER_2 then
                filename = "mods/th_immortal/files/actions/orb_large/orb_large_tier2.xml"
            end
            if caster_object.power >= TIER_3 then
                filename = "mods/th_immortal/files/actions/orb_large/orb_large_tier3.xml"
            end
            add_projectile(filename)
            c.fire_rate_wait = c.fire_rate_wait + 60
            c.screenshake = c.screenshake + 1.5
        end,
    }

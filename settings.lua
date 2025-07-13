dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "th_immortal"
mod_settings_version = 1
mod_settings =
{
    {
        id = "miss_sound",
        ui_name = "Miss sound",
        ui_description = "Enable playback of miss sound effect.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME,
    },
}

function ModSettingsUpdate(init_scope)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end

dofile_once("mods/th_immortal/files/lib/utilities.lua")
local nxml = dofile_once("mods/th_immortal/files/lib/nxml.lua")

ModLuaFileAppend("data/scripts/biomes/mountain/mountain_left_entrance.lua", "mods/th_immortal/files/saisen/mountain_left_entrance_appends.lua")
ModLuaFileAppend("data/scripts/biomes/temple_altar_left.lua", "mods/th_immortal/files/saisen/temple_altar_left_appends.lua")

ModLuaFileAppend("data/scripts/biomes/watercave.lua", "mods/th_immortal/files/narcissus/watercave_appends.lua")
ModLuaFileAppend("data/scripts/buildings/forge_item_convert.lua", "mods/th_immortal/files/narcissus/forge_item_convert_appends.lua")
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/th_immortal/files/narcissus/gun_actions_appends.lua")
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/th_immortal/files/narcissus/gun_extra_modifiers_appends.lua")
for xml in nxml.edit_file("data/entities/misc/physics_ragdoll_ai.xml") do
    xml:first_of("Base"):first_of("GenomeDataComponent").attr.herd_id = "player"
    xml:first_of("Base"):first_of("DamageModelComponent").attr.blood_material = ""
    xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_enabled = true
    xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_ranged_entity_file = "mods/th_immortal/files/actions/orb_small/orb_small.xml"
    xml:first_of("Base"):first_of("AnimalAIComponent").attr.attack_melee_enabled = false
    xml.attr.tags = xml.attr.tags .. ",th_immortal.ragdoll"
end

ModLuaFileAppend("data/scripts/biomes/mountain/mountain_floating_island.lua", "mods/th_immortal/files/jade/mountain_floating_island_appends.lua")
local physics = ModImageMakeEditable("mods/th_immortal/files/jade/jade_physics.png", 17, 17)
local ui = ModImageMakeEditable("mods/th_immortal/files/jade/jade_ui.png", 17, 17)
for i = 0, 16 do
    for j = 0, 16 do
        ModImageSetPixel(physics, j, i, bit.rshift(ModImageGetPixel(ui, j, i), 24) < 0x7F and 0x00000000 or 0x01000000)
    end
end

for xml in nxml.edit_file("data/biome/_pixel_scenes.xml") do
    xml:first_of("mBufferedPixelScenes"):create_child("PixelScene", {pos_x = 269, pos_y = -26104, just_load_an_entity = "mods/th_immortal/files/pistol/pistol.xml"})
end

ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/th_immortal/files/actions/gun_actions_appends.lua")
ModLuaFileAppend("data/scripts/items/drop_money.lua", "mods/th_immortal/files/scripts/drop_money_appends.lua")
ModRegisterAudioEventMappings("mods/th_immortal/files/audio/GUIDs.txt")
ModMaterialsFileAdd("mods/th_immortal/files/materials.xml")
append_translations("mods/th_immortal/files/translations.csv")

local receiver
local prev_power
function OnWorldPreUpdate()
    if receiver == nil then
        local updator = EntityCreateNew()
        EntityAddComponent2(updator, "LuaComponent", {script_source_file = "mods/th_immortal/files/scripts/share_pickup.lua"})
        EntityAddComponent2(updator, "LuaComponent", {script_electricity_receiver_electrified = "mods/th_immortal/files/narcissus/ragdoll_through.lua"})
        receiver = EntityAddComponent2(updator, "ElectricityReceiverComponent", {electrified_msg_interval_frames = 1})
    end
    ComponentSetValue2(receiver, "mLastFrameElectrified", GameGetFrameNum() + 1)
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        local player_object = Player(player)
        assert(player_object.script_damage)
        if prev_power ~= nil and get_tier(player_object.power) > get_tier(prev_power) then
            GamePrint("Power up!")
            GamePlaySound("mods/th_immortal/files/audio/th.bank", "event_cues/powerup/create", nil, nil)
        end
        prev_power = player_object.power
    end
end

local gui = GuiCreate()
local window = window_new(gui)
function OnWorldPostUpdate()
    local widget_list = widget_list_begin(window)

    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        local player_object = Player(player)
        local text = "Power: " .. player_object.power
        local text_width, text_height = GuiGetTextDimensions(gui, text)
        local screen_width, screen_height = GuiGetScreenDimensions(gui)
        widget_list_insert(widget_list, GuiText, screen_width - text_width - 10, screen_height - text_height - 10, text)
    end

    widget_list_end(widget_list)
end

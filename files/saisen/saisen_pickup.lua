dofile_once("mods/th_immortal/files/lib/utilities.lua")

function item_pickup(saisen, pickupper)
    local wallet = EntityGetFirstComponent(pickupper, "WalletComponent")
    if wallet == nil then return end
    local saisen_object = Saisen(saisen)
    local x, y = EntityGetTransform(saisen)

    local cost
    local count = saisen_object.pay_count + 1
    SetRandomSeed(saisen, count)
    local outcome = Random(1, 22)
    if (count < 2) then
        outcome = 10
    elseif (count <= 4) then
        outcome = math.max(outcome, 2)
    elseif (count > 4) then
        outcome = math.max(1, outcome - (count - 2))
    end
    if (outcome == 1) then
        for content in string.gmatch(saisen_object.contents, "[^,]+") do
            shoot_projectile(0, content, x, y - 6, 0, -180)
        end
        for action in string.gmatch(saisen_object.actions, "[^,]+") do
            local entity = CreateItemActionEntity(action, x, y - 6)
            local veloctiy = EntityGetFirstComponent(entity, "VelocityComponent")
            if veloctiy ~= nil then
                ComponentSetValue2(veloctiy, "mVelocity", 0, -180)
            end
        end
        EntityLoad("data/entities/particles/wand_pickup.xml", x, y - 6)
        GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/wand/create", x, y - 6)
        LoadRagdoll("mods/th_immortal/files/saisen/ragdoll/filenames.txt", x, y, "wood_static", 1, 0, -3)
        EntityKill(saisen)
        return
    elseif (outcome == 20) then
        cost = 200
    elseif (outcome == 15) then
        cost = 100
    elseif (outcome < 10) then
        cost = 20
    else
        cost = 30
    end
    cost = cost * saisen_object.cost_multiplier

    local money = ComponentGetValue2(wallet, "money") - cost
    if money < 0 then return end
    ComponentSetValue2(wallet, "money", money)
    saisen_object.pay_count = count
    mod.saisen_count = mod.saisen_count + 1
    EntityLoad("data/entities/particles/gold_pickup_particles.xml", x, y - 6)
    GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/goldnugget/create", x, y - 6)
end

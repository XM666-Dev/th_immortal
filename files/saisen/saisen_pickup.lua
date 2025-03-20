dofile_once("mods/th_immortal/files/tactic.lua")

local Saisen = Entity{
    pay_count = VariableField("th_immortal.pay_count", "value_int"),
}

function item_pickup(item, pickupper)
    local wallet = EntityGetFirstComponent(pickupper, "WalletComponent")
    if wallet == nil then return end
    local item_object = Saisen(item)
    local x, y = EntityGetTransform(item)

    local cost
    local count = item_object.pay_count + 1
    SetRandomSeed(item, count)
    local outcome = Random(1, 22)
    if (count < 2) then
        outcome = 10
    elseif (count <= 4) then
        outcome = math.max(outcome, 2)
    elseif (count > 4) then
        outcome = math.max(1, outcome - (count - 2))
    end
    if (outcome == 1) then
        EntityLoad("mods/th_immortal/files/gohei/gohei.xml", x, y)
        EntityKill(item)
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

    local money = ComponentGetValue2(wallet, "money") - cost
    if money < 0 then return end
    ComponentSetValue2(wallet, "money", money)
    item_object.pay_count = count
    GamePlaySound("data/audio/Desktop/event_cues.bank", "event_cues/goldnugget/create", x, y)
end

local function appends()
    local this = GetUpdatedEntityID()
    local x, y = EntityGetTransform(this)
    local converted = false
    for i, narcissus in ipairs(EntityGetInRadiusWithTag(x, y, 70, "th_immortal.narcissus")) do
        if EntityGetParent(narcissus) == 0 then
            AddGunActionPermanent(narcissus, "NECROMANCY")
            EntityRemoveTag(narcissus, "forgeable")
            converted = true
        end
    end
    if converted then
        GameTriggerMusicFadeOutAndDequeueAll(3.0)
        GameTriggerMusicEvent("music/oneshot/dark_01", true, x, y)
    end
end
appends()
local raw_cached_func = ____cached_func
function ____cached_func()
    raw_cached_func()
    appends()
end

for i, action in ipairs(actions) do
    if action.id == "NECROMANCY" then
        local raw_action = action.action
        action.action = function()
            c.fire_rate_wait = c.fire_rate_wait - 10
            c.extra_entities = c.extra_entities .. "mods/th_immortal/files/narcissus/necromancy_shot.xml,"
            raw_action()
        end
    end
end

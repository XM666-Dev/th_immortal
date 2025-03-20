for i, action in ipairs(actions) do
    if action.id == "NECROMANCY" then
        local f = action.action
        action.action = function()
            c.fire_rate_wait = c.fire_rate_wait - 10
            f()
        end
    end
end

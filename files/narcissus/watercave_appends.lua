local raw_spawn_props = spawn_props
function spawn_props(x, y)
    raw_spawn_props(x, y)
    EntityLoad("mods/th_immortal/files/narcissus/narcissus.xml", x + 10, y)
end

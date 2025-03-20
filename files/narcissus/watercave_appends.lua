local f = spawn_props
function spawn_props(x, y)
    f(x, y)
    EntityLoad("mods/th_immortal/files/narcissus/narcissus.xml", x + 10, y)
end

local f = spawn_orb
function spawn_orb(x, y)
    f(x, y)
    EntityLoad("mods/th_immortal/files/jade/jade.xml", x - 18, y)
end

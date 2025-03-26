local raw_spawn_orb = spawn_orb
function spawn_orb(x, y)
    raw_spawn_orb(x, y)
    EntityLoad("mods/th_immortal/files/jade/jade.xml", x - 18, y)
end

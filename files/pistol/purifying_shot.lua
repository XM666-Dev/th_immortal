dofile_once("mods/th_immortal/files/lib/utilities.lua")

function shot(projectile)
    for i, emitter in ipairs(EntityGetComponent(projectile, "ParticleEmitterComponent") or {}) do
        remove_component(emitter)
    end
end

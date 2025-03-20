function shot(projectile)
    for i, emitter in ipairs(EntityGetComponent(projectile, "ParticleEmitterComponent") or {}) do
        EntitySetComponentIsEnabled(projectile, emitter, false)
    end
end

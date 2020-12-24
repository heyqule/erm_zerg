---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 6:40 PM
---

local ProjectileAnimation = {}

function ProjectileAnimation.create_lurker_spike()
    return {
        type = "explosion",
        name = "lurker-explosion",
        flags = {"not-on-map"},
        render_layer = 'projectile',
        animations =
        {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/lurker_spike.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                frame_count = 6,
                animation_speed = 0.2,
                scale = 3,
                run_mode = "forward-then-backward",
            }
        }
    }
end

function ProjectileAnimation.create_colony_spike()
    return {
        type = "explosion",
        name = "colony-explosion",
        flags = {"not-on-map"},
        render_layer = 'projectile',
        animations =
        {
            layers = {
                {
                    filename = "__erm_zerg__/graphics/entity/projectiles/colony_spike.png",
                    priority = "extra-high",
                    width = 128,
                    height = 128,
                    frame_count = 6,
                    animation_speed = 0.2,
                    scale = 2,
                    run_mode = "forward-then-backward",
                },
                {
                    filename = "__erm_zerg__/graphics/entity/projectiles/colony_spike.png",
                    priority = "extra-high",
                    width = 128,
                    height = 128,
                    frame_count = 6,
                    animation_speed = 0.2,
                    scale = 2,
                    draw_as_shadow = true,
                    shift = {0.15, 0.1},
                    run_mode = "forward-then-backward",
                }
            }
        }
    }
end

function ProjectileAnimation.create_mutalisk_ball()
    return {
            type = "projectile",
            name = "mutalisk-projectile",
            flags = {"not-on-map"},
            acceleration = 0.005,
            action =
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-entity",
                            entity_name = "mutalisk-explosion-small"
                        }
                    }
                }
            },
            animation =
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/spores_1.png",
                frame_count = 10,
                width = 36,
                height = 36,
                priority = "high",
                run_mode = 'forward-then-backward'
            }
        }
end

function ProjectileAnimation.create_mutalisk_hit_effect()
    return {
        type = "explosion",
        name = "mutalisk-explosion-small",
        flags = {"not-on-map"},
        animations =
        {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/spores_2.png",
                priority = "extra-high",
                width = 24,
                height = 24,
                frame_count = 4,
                animation_speed = 0.2,
                scale=1.5
            }
        }
    }
end

function ProjectileAnimation.create_hydralisk_projectile()
    return     {
        type = "projectile",
        name = "hydralisk-projectile",
        flags = {"not-on-map"},
        acceleration = 0.05,
        action =
        {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                target_effects =
                {
                    {
                        type = "create-entity",
                        entity_name = "hydralisk-explosion-small"
                    }
                }
            }
        },
        animation =
        {
            filename = "__erm_zerg__/graphics/entity/projectiles/hydra_pr.png",
            frame_count = 1,
            width = 21,
            height = 49,
            priority = "high",
            animation_speed = 0.2
        }
    }
end

function ProjectileAnimation.create_hydralisk_hit()
    return {
        type = "explosion",
        name = "hydralisk-explosion-small",
        flags = {"not-on-map"},
        animations =
        {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/hydra_acid.png",
                priority = "extra-high",
                width = 31,
                height = 32,
                line_length = 8,
                frame_count = 8,
                animation_speed = 0.2
            }
        }
    }
end

function ProjectileAnimation.create_hydralisk_hit()
    return {
        type = "explosion",
        name = "hydralisk-explosion-small",
        flags = {"not-on-map"},
        animations =
        {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/hydra_acid.png",
                priority = "extra-high",
                width = 31,
                height = 32,
                line_length = 8,
                frame_count = 8,
                animation_speed = 0.2
            }
        }
    }
end

function ProjectileAnimation.create_defiler_cloud()
    return
        {
            filename = "__erm_zerg__/graphics/entity/projectiles/defiler_blood.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 14,
            animation_speed = 0.2,
            scale = 2
        }
end

function ProjectileAnimation.create_queen_cloud()
    return
    {
        filename = "__erm_zerg__/graphics/entity/projectiles/queen_heal.png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 14,
        animation_speed = 0.2,
        scale = 2
    }
end

return ProjectileAnimation
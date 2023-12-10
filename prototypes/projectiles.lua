---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 6:40 PM
---

local Sprites = require('__stdlib__/stdlib/data/modules/sprites')
local ERMDataHelper = require('__enemyracemanager__/lib/rig/data_helper')

data:extend({
    --- Projectiles
    {
        type = "projectile",
        name = MOD_NAME.."/mutalisk-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = MOD_NAME.."/mutalisk-explosion-small"
                    },
                    {
                        type = "damage",
                        damage = { amount = 20, type = "acid" }
                    }
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/spores_1.png",
            frame_count = 10,
            width = 36,
            height = 36,
            run_mode = 'forward-then-backward',
            animation_speed = 0.5
        }
    },
    {
        type = "projectile",
        name = MOD_NAME.."/parasite-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "script",
                    effect_id = QUEEN_SPAWN,
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/parasite.png",
            frame_count = 1,
            width = 20,
            height = 20,
            direction_count = 16,
            animation_speed = 0.5,
            scale = 2
        }
    },
    {
        type = "projectile",
        name = MOD_NAME.."/hydralisk-projectile",
        flags = { "not-on-map" },
        acceleration = 0.05,

        direction_only = true,
        collision_box = {{-0.5,-0.5},{0.5,0.5}},
        force_condition = "not-same",
        hit_collision_mask = {"player-layer", "train-layer", "transport-belt-layer", ERMDataHelper.getFlyingLayerName()},
        hit_at_collision_position = true,

        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = MOD_NAME.."/hydralisk-explosion-small"
                    },
                    {
                        type = "damage",
                        damage = { amount = 15, type = "acid" },
                        apply_damage_to_trees = true
                    }
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/hydra_pr.png",
            frame_count = 1,
            width = 21,
            height = 49,
            animation_speed = 0.5
        }
    },
    {
        type = "projectile",
        name = MOD_NAME.."/guardian-projectile",
        flags = { "not-on-map" },
        acceleration = 0.01,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = MOD_NAME.."/mutalisk-explosion-small"
                    },
                    {
                        type = "damage",
                        damage = { amount = 40, type = "acid" },
                        apply_damage_to_trees = true
                    },
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/spores_2.png",
            width = 24,
            height = 24,
            frame_count = 4,
            animation_speed = 0.5,
            scale = 2
        }
    },
    --- Explosions
    {
        type = "explosion",
        name = MOD_NAME.."/lurker-explosion",
        flags = { "not-on-map" },
        render_layer = 'projectile',
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/lurker_spike.png",
                width = 128,
                height = 128,
                frame_count = 6,
                animation_speed = 0.4,
                scale = 3,
                run_mode = "forward-then-backward",
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/colony-explosion",
        flags = { "not-on-map" },
        render_layer = 'projectile',
        animations = {
            layers = {
                {
                    filename = "__erm_zerg__/graphics/entity/projectiles/colony_spike.png",
                    width = 128,
                    height = 128,
                    frame_count = 6,
                    animation_speed = 0.4,
                    scale = 2,
                    run_mode = "forward-then-backward",
                },
                {
                    filename = "__erm_zerg__/graphics/entity/projectiles/colony_spike.png",
                    width = 128,
                    height = 128,
                    frame_count = 6,
                    animation_speed = 0.4,
                    scale = 2,
                    draw_as_shadow = true,
                    shift = { 0.15, 0.1 },
                    run_mode = "forward-then-backward",
                }
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/mutalisk-explosion-small",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/spores_2.png",
                width = 24,
                height = 24,
                frame_count = 4,
                animation_speed = 0.4,
                scale = 1.5
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/hydralisk-explosion-small",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/hydra_acid.png",
                width = 31,
                height = 32,
                line_length = 8,
                frame_count = 8,
                animation_speed = 0.4
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/blood-cloud-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/defiler_blood.png",
                width = 128,
                height = 128,
                frame_count = 14,
                animation_speed = 0.4,
                scale = 2
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/dark-swarm-80-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/darkswarm-80.png",
                width = 256,
                height = 256,
                frame_count = 35,
                frame_sequence = {1,2,3,4,5,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,5,4,3,2,1},
                animation_speed = 0.4,
                scale = 2
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/dark-swarm-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/darkswarm.png", -- 5 seconds
                width = 256,
                height = 256,
                frame_count = 60,
                frame_sequence = {1,2,3,4,5,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,7,8,9,10,9,8,7,6,5,4,3,2,1},
                animation_speed = 0.4,
                scale = 2
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/acid-cloud-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/snare.png",
                width = 128,
                height = 128,
                frame_count = 14,
                animation_speed = 0.4,
                scale = 2
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/devourer-cloud-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/devourer_puke_hit.png",
                width = 56,
                height = 56,
                frame_count = 16,
                animation_speed = 0.4,
                scale = 1.5
            }
        }
    },
    {
        type = "explosion",
        name = MOD_NAME.."/scourge-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/scourge_explosion.png",
                width = 48,
                height = 48,
                frame_count = 9,
                animation_speed = 0.4,
                scale = 1.3
            }
        }
    }
})
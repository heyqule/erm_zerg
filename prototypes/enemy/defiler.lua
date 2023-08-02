--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')
local Sprites = require('__stdlib__/stdlib/data/modules/sprites')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ERM_Config = require('__enemyracemanager__/lib/global_config')
local ZergSound = require('__erm_zerg__/prototypes/sound')

local name = 'defiler'


local hitpoint = 80
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 2


-- Handles acid and poison resistance
local base_acid_resistance = 20
local incremental_acid_resistance = 70
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 95
-- Handles fire and explosive resistance
local base_fire_resistance = 10
local incremental_fire_resistance = 80
-- Handles laser and electric resistance
local base_electric_resistance = 0
local incremental_electric_resistance = 85
-- Handles cold resistance
local base_cold_resistance = 0
local incremental_cold_resistance = 85

-- Handles damages

local base_acid_damage = 10
local incremental_acid_damage = 20

local base_healing = 40
local incremental_healing = 80

-- Handles Attack Speed

local base_attack_speed = 600
local incremental_attack_speed = 300

local attack_range = ERM_Config.get_max_attack_range()


local base_movement_speed = 0.125
local incremental_movement_speed = 0.075

-- Misc settings
local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)

local pollution_to_join_attack = 300
local distraction_cooldown = 300

-- Animation Settings
local unit_scale = 1.5

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -0.75 }, { 0.75, 0.75 } }

function ErmZerg.make_defiler(level)
    level = level or 1


    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air" },
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. '/'  .. name .. '/' .. level,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_zerg-map-color'].value),
            shooting_cursor_size = 2,
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance,  level) },
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance,  level) }
            },
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_multiplier,  level),
            --collision_mask = { "player-layer" },
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed,  level),
            pollution_to_join_attack = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level),
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            spawning_time_modifier = 2,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                range = attack_range,
                min_attack_distance = attack_range - 4,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level) - 90,
                cooldown_deviation = 0.1,
                warmup = 6,
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        {
                            type = "direct",
                            ignore_collision_condition = true,
                            force = 'same',
                            probability = 0.05,
                            action_delivery = {
                                type = "instant",
                                source_effects = {
                                    {
                                        type = "create-smoke",
                                        show_in_tooltip = true,
                                        entity_name = MOD_NAME .. "/dark-swarm-" .. level
                                    },
                                    {
                                        type = "create-explosion",
                                        entity_name = "dark-swarm-80-explosion"
                                    }
                                }
                            }
                        },
                        {
                            type = "direct",
                            ignore_collision_condition = true,
                            force = 'same',
                            probability = 0.075,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "create-smoke",
                                        show_in_tooltip = true,
                                        entity_name = MOD_NAME .. "/dark-swarm-" .. level
                                    },
                                    {
                                        type = "create-explosion",
                                        entity_name = "dark-swarm-80-explosion"
                                    }
                                }
                            }
                        },
                        {
                            type = "direct",
                            probability = 0.95,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "create-smoke",
                                        show_in_tooltip = true,
                                        entity_name = MOD_NAME .. "/blood-cloud-" .. level
                                    },
                                    {
                                        type = "create-explosion",
                                        entity_name = "blood-cloud-explosion"
                                    }
                                }
                            }
                        },
                    }
                },
                sound = ZergSound.defiler_attack(0.75),
                animation = {
                    layers = {
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                            width = 80,
                            height = 80,
                            frame_count = 8,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.5
                        },
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                            width = 80,
                            height = 80,
                            frame_count = 8,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            draw_as_shadow = true,
                            tint = ERM_UnitTint.tint_shadow(),
                            animation_speed = 0.5,
                            shift = {0.2, 0}
                        }
                    }
                }
            },

            distance_per_frame = 0.22,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 80,
                        height = 80,
                        frame_count = 8,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 80,
                        height = 80,
                        frame_count = 8,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        draw_as_shadow = true,
                        animation_speed = 1,
                        shift={0.2, 0}
                    }
                }
            },
            dying_sound = ZergSound.enemy_death(name, 0.75),
            corpse = name .. '-corpse'
        },
        {
            type = "corpse",
            name = name .. '-corpse',
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = defines.time.minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
            subgroup = "corpses",
            order = MOD_NAME .. "/" .. name .. level,
            final_render_layer = "corpse",
            animation = {
                filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-death.png",
                width = 80,
                height = 80,
                frame_count = 4,
                direction_count = 1,
                axially_symmetrical = false,
                scale = unit_scale,
                animation_speed = 0.2
            },
        },
        {
            name = MOD_NAME .. "/blood-cloud-" .. level,
            localised_name = {'entity-name.blood-cloud'},
            type = "smoke-with-trigger",
            flags = { "not-on-map" },
            show_when_smoke_off = true,
            particle_count = 1,
            --particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
            --particle_distance_scale_factor = 0.5,
            --particle_scale_factor = { 1, 0.707 },
            --wave_speed = { 1/80, 1/60 },
            --wave_distance = { 0.3, 0.2 },
            --spread_duration_variation = 20,
            --particle_duration_variation = 60 * 3,
            render_layer = "explosion",

            affected_by_wind = false,
            duration = 120,
            cyclic = true,
            --spread_duration = 20,

            animation = Sprites.empty_picture(),
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = 5,
                            force = 'not-same',
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "damage",
                                    damage = { amount = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage,  level), type = "acid" },
                                    apply_damage_to_trees = true
                                }
                            }
                        }
                    }
                }
            },
            action_cooldown = 15
        },
        {
            name = MOD_NAME .. "/dark-swarm-" .. level,
            localised_name = {'entity-name.dark-swarm'},
            type = "smoke-with-trigger",
            flags = { "not-on-map" },
            show_when_smoke_off = true,
            particle_count = 1,
            --particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
            --particle_distance_scale_factor = 0.5,
            --particle_scale_factor = { 1, 0.707 },
            --wave_speed = { 1/80, 1/60 },
            --wave_distance = { 0.3, 0.2 },
            --spread_duration_variation = 20,
            --particle_duration_variation = 60 * 3,
            render_layer = "explosion",

            affected_by_wind = false,
            duration = 180,
            cyclic = true,
            --spread_duration = 20,

            animation = Sprites.empty_picture(),
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = 8,
                            force = 'same',
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "damage",
                                    damage = { amount = ERM_UnitHelper.get_damage(base_healing, incremental_healing,  level) * -1, type = "healing" },
                                }
                            }
                        }
                    }
                }
            },
            action_cooldown = 12
        },
    })
end

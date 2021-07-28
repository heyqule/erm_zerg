--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')
local Sprites = require('__stdlib__/stdlib/data/modules/sprites')
local ERM_UnitHelper = require('__enemyracemanager__/lib/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ERM_Config = require('__enemyracemanager__/lib/global_config')
local ERMDataHelper = require('__enemyracemanager__/lib/helper/data_helper')
local ZergSound = require('__erm_zerg__/prototypes/sound')
local ZergProjectileAnimation = require('__erm_zerg__/prototypes/projectile_animation')
local name = 'queen'

local health_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local hitpoint = 120
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.5

local resistance_mutiplier = settings.startup["enemyracemanager-level-multipliers"].value
-- Handles acid and poison resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 65
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

-- Handles physical damages
local damage_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_heal_damage = 100 / 4 / 2
local incremental_heal_damage = 400 / 4 / 2
local base_acid_damage = 25 / 4 / 2
local incremental_acid_damage = 25 / 4 / 2

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 600
local incremental_attack_speed = 180

local attack_range = ERM_Config.get_max_attack_range()

local movement_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_movement_speed = 0.15
local incremental_movement_speed = 0.1

-- Misc settings
local vision_distance = 35

local pollution_to_join_attack = 400
local distraction_cooldown = 20

-- Animation Settings
local unit_scale = 1.5
local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -0.75 }, { 0.75, 0.75 } }

function ErmZerg.make_queen(level)
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
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. '/'  .. name .. '/' .. level,
            subgroup = "flying-enemies",
            shooting_cursor_size = 2,
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance, resistance_mutiplier, level) },
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance, resistance_mutiplier, level) }
            },
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
            collision_mask = ERMDataHelper.getFlyingCollisionMask(),
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed, movement_multiplier, level),
            pollution_to_join_attack = pollution_to_join_attack,
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            attack_parameters = {
                type = "projectile",
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level) - 30,
                cooldown_deviation = 0.1,
                warmup = 6,
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-smoke",
                                    show_in_tooltip = true,
                                    entity_name = name .. "-healing-cloud-" .. level
                                },
                                {
                                    type = "create-explosion",
                                    entity_name = "queen-cloud-explosion"
                                }
                            }
                        }
                    },
                },
                sound = ZergSound.defiler_attack(0.75),
                lead_target_for_projectile_speed = 5,
                animation = {
                    layers = {
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 128,
                            height = 128,
                            frame_count = 6,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.6
                        },
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 128,
                            height = 128,
                            frame_count = 6,
                            axially_symmetrical = false,
                            direction_count = 16,
                            shift = { 4, 0 },
                            scale = unit_scale,
                            draw_as_shadow = true,
                            tint = ERM_UnitTint.tint_shadow(),
                            animation_speed = 0.6,
                            shift = {4, 0}
                        }
                    }
                }
            },

            distance_per_frame = 0.22,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 128,
                        height = 128,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 128,
                        height = 128,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,
                        shift = { 4, 0 },
                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        draw_as_shadow = true,
                        animation_speed = 1,
                        shift = {4, 0}
                    }
                }
            },
            dying_explosion = name .. "-air-death",
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
            time_before_removed = defines.time.second,
            subgroup = "corpses",
            order = "x" .. name .. level,
            animation = Sprites.empty_pictures(),
        },
        {
            type = "explosion",
            name = name .. "-air-death",
            flags = { "not-on-map" },
            animations = {
                filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-death.png",
                width = 140,
                height = 140,
                frame_count = 9,
                direction_count = 1,
                axially_symmetrical = false,
                scale = unit_scale,
                animation_speed = 0.5
            }
        },
        {
            name = name .. "-healing-cloud-" .. level,
            localised_name = {'entity-name.healing-cloud'},
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
            cyclic = true,
            duration = 120,
            fade_away_duration = 120,
            --spread_duration = 20,

            animation = Sprites.empty_picture(),
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "nested-result",
                            action = {
                                type = "area",
                                force = 'not-same',
                                radius = 5,
                                force = 'ally',
                                ignore_collision_condition = true,
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        type = "damage",
                                        damage = { amount = -1 * ERM_UnitHelper.get_damage(base_heal_damage, incremental_heal_damage, damage_multiplier, level), type = "healing" }
                                    }
                                }
                            }
                        },
                        {
                            type = "nested-result",
                            action = {
                                type = "area",
                                force = 'not-same',
                                radius = 5,
                                ignore_collision_condition = true,
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        type = "damage",
                                        damage = { amount = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage, damage_multiplier, level), type = "acid" }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            action_cooldown = 15
        },
    })
end

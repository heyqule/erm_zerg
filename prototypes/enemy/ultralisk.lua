--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ZergSound = require('__erm_zerg__/prototypes/sound')
local name = 'ultralisk'

local health_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local hitpoint = 400
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.5

local resistance_mutiplier = settings.startup["enemyracemanager-level-multipliers"].value
-- Handles acid and poison resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 70
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 95
-- Handles fire and explosive resistance
local base_fire_resistance = 15
local incremental_fire_resistance = 80
-- Handles laser and electric resistance
local base_electric_resistance = 0
local incremental_electric_resistance = 90
-- Handles cold resistance
local base_cold_resistance = 0
local incremental_cold_resistance = 90

-- Handles physical damages
local damage_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_physical_damage = 50
local incremental_physical_damage = 100

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 90
local incremental_attack_speed = 45

local attack_range = 1

local movement_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_movement_speed = 0.2
local incremental_movement_speed = 0.075

-- Misc settings
local vision_distance = 35
local pollution_to_join_attack = 500
local distraction_cooldown = 20

-- Animation Settings
local unit_scale = 1.5

local collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
local selection_box = { { -1, -1 }, { 1, 1 } }

function ErmZerg.make_ultralisk(level)
    level = level or 1

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air" },
            has_belt_immunity = true,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. '/'  .. name .. '/' .. level,
            subgroup = "enemies",
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
            --collision_mask = { "player-layer" },
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
                ammo_category = 'biological',
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.1,
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "area",
                        radius = 3,
                        ignore_collision_condition = true,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = {
                                        amount = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage, damage_multiplier, level),
                                        type = "physical"
                                    },
                                    apply_damage_to_trees = true
                                }
                            }
                        }
                    }
                },
                sound = ZergSound.meele_attack(0.75),
                animation = {
                    layers = {
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 128,
                            height = 128,
                            frame_count = 5,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.25
                        },
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-attack-mask.png",
                            width = 128,
                            height = 128,
                            frame_count = 5,
                            axially_symmetrical = false,
                            direction_count = 16,

                            scale = unit_scale,
                            tint = ERM_UnitTint.tint_shadow(),
                            draw_as_shadow = true,
                            animation_speed = 0.25
                        }
                    }
                }
            },
            distance_per_frame = 0.15,
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
                        animation_speed = 0.3,
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run-mask.png",
                        width = 128,
                        height = 128,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,

                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        draw_as_shadow = true,
                        animation_speed = 0.3,
                    }
                }
            },
            dying_explosion = "blood-explosion-small",
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
            order = "x" .. name .. level,
            final_render_layer = "lower-object-above-shadow",
            animation = {
                filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-death.png",
                width = 128,
                height = 128,
                frame_count = 7,
                direction_count = 1,
                axially_symmetrical = false,
                scale = unit_scale,
                animation_speed = 0.2
            },
        }
    })
end
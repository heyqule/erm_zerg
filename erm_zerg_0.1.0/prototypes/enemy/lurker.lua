--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/19/2020
-- Time: 7:14 PM
-- To change this template use File | Settings | File Templates.
--

require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit-helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit-tint')
local ZergSound = require('__erm_zerg__/prototypes/sound')
local name = 'lurker'

local health_multiplier = 5
local hitpoint = 125
local max_hitpoint_mutiplier = 10 * 1.5

local resistance_mutiplier = 5
-- Handles acid and poisi resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 65
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 90
-- Handles fire and explosive resistance
local base_fire_resistance = 10
local incremental_fire_resistance = 80
-- Handles laser and electric resistance
local base_eletric_resistance = 0
local incremental_eletric_resistance = 90
-- Handles cold resistance
local base_cold_resistance = 25
local incremental_cold_resistance = 65

-- Handles acid damages
local damage_multiplier = 5
local base_physical_damage = 20
local incremental_physical_damage = 55

-- Handles Attack Speed
local attack_speed_multiplier = 5
local base_attack_speed = 200
local incremental_attack_speed = 90

local attack_range = 16

local movement_multiplier = 5
local base_movement_speed = 0.15
local incremental_movement_speed = 0.075

-- Misc settings
local vision_distance = 48
local pollution_to_join_attack = 2
local distraction_cooldown = 20

-- Animation Settings
local unit_scale = 1.3

local selection_box = { { -1.0, -1.0 }, { 1.0, 1.0 } }

function ErmZerg.makeLurker(level)
    level = level or 1

    data:extend({
        {
            type = "unit",
            name = 'erm'..'-'..name .. '-' .. level,
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64, icon_mipmaps = 4,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", "not-repairable"},
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_mutiplier, health_multiplier, level),
            order = "erm-" .. name .. '-' .. level,
            subgroup = "enemies",
            shooting_cursor_size = 2,
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level)},
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance, resistance_mutiplier, level)},
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level)},
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level)},
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_eletric_resistance, incremental_eletric_resistance, resistance_mutiplier, level)},
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_eletric_resistance, incremental_eletric_resistance, resistance_mutiplier, level)},
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance, resistance_mutiplier, level)}
            },
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_mutiplier, health_multiplier, level),
            --collision_mask = { "player-layer" },
            collision_box = selection_box,
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
                warmup = 30,
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        type = "area",
                        radius = 3,
                        action_delivery = {
                            type = "instant",
                            target_effects =
                            {
                                {
                                    type="create-explosion",
                                    entity_name = name.."-explosion-"..level
                                },
                                {
                                    type = "damage",
                                    damage = {amount = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage, damage_multiplier, level), type = "physical"}
                                },
                            }
                        }
                    },
                },
                sound = ZergSound.lurker_attack(0.6),
                animation = {
                    layers = {
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-burrow-combined.png",
                            width = 128,
                            height = 128,
                            line_length = 9,
                            frame_count = 18,
                            axially_symmetrical = false,
                            direction_count = 1,
                            scale = unit_scale,
                            animation_speed = 0.5
                        },
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-burrow-combined-mask.png",
                            width = 128,
                            height = 128,
                            line_length = 9,
                            frame_count = 18,
                            axially_symmetrical = false,
                            direction_count = 1,
                            flags = { "mask" },
                            scale = unit_scale,
                            tint = ERM_UnitTint.tint_shadow(),
                            draw_as_shadow = true,
                            animation_speed = 0.5
                        }
                    }
                }
            },

            distance_per_frame = 0.17,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 128,
                        height = 128,
                        frame_count = 6,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 0.6,
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run-mask.png",
                        width = 128,
                        height = 128,
                        frame_count = 6,
                        axially_symmetrical = false,
                        direction_count = 16,
                        flags = { "mask" },
                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        draw_as_shadow = true,
                        animation_speed = 0.6,
                    }
                }
            },
            dying_explosion = "blood-explosion-small",
            dying_sound = {
                filename = "__erm_zerg__/sound/enemies/" .. name .. "/death.ogg",
                volume = 1
            },
            corpse = name .. '-corpse'
        },
        {
            type = "corpse",
            name = name .. '-corpse',
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64, icon_mipmaps = 4,
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
                frame_count = 6,
                direction_count = 1,
                axially_symmetrical = false,
                scale = unit_scale,
                animation_speed = 0.2
            },
        },
        {
            type = "explosion",
            name = name.."-explosion-"..level,
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
        },
    })

end
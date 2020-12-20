--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit-helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit-tint')
local ZergSound = require('__erm_zerg__/prototypes/sound')
local name = 'mutalisk'

-- Hitpoints
local health_multiplier = 5
local hitpoint = 120
local max_hitpoint_mutiplier = 10 * 1.5

local resistance_mutiplier = 5
-- Handles acid and poisi resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 65
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 90
-- Handles fire and explosive resistance
local base_fire_resistance = 15
local incremental_fire_resistance = 75
-- Handles laser and electric resistance
local base_eletric_resistance = 0
local incremental_eletric_resistance = 90
-- Handles cold resistance
local base_cold_resistance = 25
local incremental_cold_resistance = 65

-- Handles damages
local damage_multiplier = 5
local base_acid_damage = 15
local incremental_acid_damage = 45

-- Handles Attack Speed
local attack_speed_multiplier = 5
local base_attack_speed = 150
local incremental_attack_speed = 75

local attack_range = 6

local movement_multiplier = 5
local base_movement_speed = 0.25
local incremental_movement_speed = 0.0725

-- Misc Settings
local vision_distance = 45
local pollution_to_join_attack = 50
local distraction_cooldown = 20

-- Animation Settings
local unit_scale = 1.3

local selection_box = {{-0.5, -0.5}, {0.5, 0.5}}

function ErmZerg.makeMutalisk(level)
level = level or 1

data:extend({
    {
        type = "unit",
        name = 'erm'..'-'..name .. '-' .. level,
        icon = "__erm_zerg__/graphics/entity/icons/units/"..name..".png",
        icon_size = 64, icon_mipmaps = 4,
        flags = {"placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", "not-repairable", 'not-flammable'},
        has_belt_immunity = true,
        max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_mutiplier, health_multiplier, level),
        order = "erm-"..name..'-'..level,
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
        collision_mask = {},
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
            warmup = 10,
            ammo_type = {
                category = "biological",
                target_type = "direction",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "projectile",
                        projectile = name.."-projectile"..level,
                        starting_speed = 1.5
                    }
                }
            },
            sound = ZergSound.mutalisk_attack(0.6),
            animation = {
                layers={
                    {
                        filename = "__erm_zerg__/graphics/entity/units/"..name.."/"..name.."-run.png",
                        width = 128,
                        height = 128,
                        frame_count = 3,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 0.2,
                        run_mode = 'forward-then-backward'
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/"..name.."/"..name.."-run-mask.png",
                        width = 128,
                        height = 128,
                        frame_count = 3,
                        axially_symmetrical = false,
                        direction_count = 16,
                        flags = {"mask"},
                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        animation_speed = 0.2,
                        draw_as_shadow = true,
                        run_mode = 'forward-then-backward',
                        shift = {4, 0}
                    }
                }
            }
        },

        render_layer = "air-object",
        final_render_layer = "air-object",
        distance_per_frame = 0.5,
        run_animation = {
            layers={
                {
                    filename = "__erm_zerg__/graphics/entity/units/"..name.."/"..name.."-run.png",
                    width = 128,
                    height = 128,
                    frame_count = 3,
                    axially_symmetrical = false,
                    direction_count = 16,
                    scale = unit_scale,
                    animation_speed = 0.6,
                    run_mode = 'forward-then-backward'
                },
                {
                    filename = "__erm_zerg__/graphics/entity/units/"..name.."/"..name.."-run-mask.png",
                    width = 128,
                    height = 128,
                    frame_count = 3,
                    axially_symmetrical = false,
                    direction_count = 16,
                    flags = {"mask"},
                    scale = unit_scale,
                    tint = ERM_UnitTint.tint_shadow(),
                    shift = {4, 0},
                    animation_speed = 0.6,
                    draw_as_shadow = true,
                    run_mode = 'forward-then-backward'
                }
            }
        },
        dying_explosion = "blood-explosion-small",
        dying_sound = {
            filename = "__erm_zerg__/sound/enemies/"..name.."/death.ogg",
            volume = 1
        },

        corpse = name..'-corpse'
    },
    {
        type = "corpse",
        name = name..'-corpse',
        icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
        icon_size = 64, icon_mipmaps = 4,
        flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
        selection_box = selection_box,
        selectable_in_game = false,
        dying_speed = 0.04,
        time_before_removed = defines.time.second * 5,
        subgroup = "corpses",
        order = "x" .. name .. level,
        final_render_layer = "lower-object-above-shadow",
        animation = {
            filename = "__erm_zerg__/graphics/entity/units/"..name.."/"..name.."-death.png",
            width = 80,
            height = 80,
            frame_count = 9,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 1.25,
            animation_speed=0.2
        },
        final_render_layer = "lower-object-above-shadow"
    },
    {
        type = "projectile",
        name = name.."-projectile"..level,
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
                        entity_name = name.."-explosion-small"
                    },
                    {
                        type = "damage",
                        damage = {amount = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage, damage_multiplier, level), type = "acid"}
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
    },
    {
        type = "explosion",
        name = name.."-explosion-small",
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
})
end

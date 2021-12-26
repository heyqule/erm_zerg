---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 12:37 AM
---
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ZergSound = require('__erm_zerg__/prototypes/sound')

local enemy_autoplace = require("__enemyracemanager__/lib/enemy-autoplace-utils")
local name = 'sunker_colony'
local short_range_name = 'sunker_colony_shortrange'
-- Hitpoints
local health_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local hitpoint = 400
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value

local resistance_mutiplier = settings.startup["enemyracemanager-level-multipliers"].value
-- Handles acid and poison resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 55
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 85
-- Handles fire and explosive resistance
local base_fire_resistance = 10
local incremental_fire_resistance = 70
-- Handles laser and electric resistance
local base_electric_resistance = 0
local incremental_electric_resistance = 75
-- Handles cold resistance
local base_cold_resistance = 0
local incremental_cold_resistance = 75

local collision_box = { { -2, -2 }, { 2, 2 } }
local map_generator_bounding_box = { { -3, -3 }, { 3, 3 } }
local selection_box = { { -2, -2 }, { 2, 2 } }

-- Handles damages
local damage_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_physical_damage = 1
local incremental_physical_damage = 14

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 120
local incremental_attack_speed = 60

local attack_range = 30

-- Animation Settings
local unit_scale = 1.5

local folded_animation = function()
    return {
        layers = {
            {
                filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. ".png",
                width = 128,
                height = 128,
                frame_count = 3,
                direction_count = 1,
                scale = unit_scale,
                run_mode = "forward-then-backward",
            },
        }
    }
end

local attack_animation = function()
    return {
        layers = {
            {
                filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. "_attack.png",
                width = 128,
                height = 128,
                frame_count = 11,
                direction_count = 1,
                scale = unit_scale,
                run_mode = "forward-then-backward",
            },
        }
    }
end

function ErmZerg.make_sunker_colony(level)
    level = level or 1

    data:extend({
        {
            type = "turret",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_zerg__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "breaths-air" },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. '/' .. name,
            subgroup = "enemies",
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
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
            shooting_cursor_size = 4,
            rotation_speed = 1,
            corpse = "zerg-small-base-corpse",
            dying_explosion = "zerg-building-explosion",
            dying_sound = ZergSound.building_dying_sound(0.75),
            call_for_help_radius = 50,
            folded_speed = 0.01,
            folded_speed_secondary = 0.01,
            folded_animation = folded_animation(),
            working_sound = ZergSound.sunker_idle(0.75),
            starting_attack_animation = attack_animation(),
            starting_attack_speed = 0.02,
            starting_attack_sound = ZergSound.sunker_attack(0.75),
            integration = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. "_filler.png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. "_filler.png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        draw_as_shadow = true,
                        shift = { 0.25, 0.1 },
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        draw_as_shadow = true,
                        shift = { 0.25, 0.1 },
                        scale = unit_scale
                    }
                }
            },
            autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'biological',
                acceleration = 0,
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.25,
                warmup = 12,
                damage_modifier = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage, damage_multiplier, level),
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-explosion",
                                    entity_name = 'colony-explosion'
                                },
                                {
                                    type = "play-sound",
                                    sound = ZergSound.sunker_hit(0.75),
                                },
                                {
                                    type = "damage",
                                    damage = { amount = 15, type = "physical" }
                                },
                            }
                        }
                    },
                },
            },
        },
        {
            type = "turret",
            name = MOD_NAME .. '/' .. short_range_name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. short_range_name, level },
            icon = "__erm_zerg__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "breaths-air" },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. '/' .. name,
            subgroup = "enemies",
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
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
            shooting_cursor_size = 4,
            rotation_speed = 1,
            corpse = "zerg-small-base-corpse",
            dying_explosion = "zerg-building-explosion",
            dying_sound = ZergSound.building_dying_sound(0.75),
            call_for_help_radius = 50,
            folded_speed = 0.01,
            folded_speed_secondary = 0.01,
            folded_animation = folded_animation(),
            working_sound = ZergSound.sunker_idle(0.75),
            starting_attack_animation = attack_animation(),
            starting_attack_speed = 0.02,
            starting_attack_sound = ZergSound.sunker_attack(0.75),
            integration = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. "_filler.png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. "_filler.png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        draw_as_shadow = true,
                        shift = { 0.25, 0.1 },
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        draw_as_shadow = true,
                        shift = { 0.25, 0.1 },
                        scale = unit_scale
                    }
                }
            },
            autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'biological',
                acceleration = 0,
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.25,
                warmup = 12,
                damage_modifier = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage, damage_multiplier, level),
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-explosion",
                                    entity_name = 'colony-explosion'
                                },
                                {
                                    type = "play-sound",
                                    sound = ZergSound.sunker_hit(0.75),
                                },
                                {
                                    type = "damage",
                                    damage = { amount = 15, type = "physical" }
                                },
                            }
                        }
                    },
                },
            },
        },
    })
end
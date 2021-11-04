---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 12:37 AM
---
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ERM_Config = require('__enemyracemanager__/lib/global_config')
local ZergSound = require('__erm_zerg__/prototypes/sound')

local enemy_autoplace = require("__enemyracemanager__/lib/enemy-autoplace-utils")
local name = 'spore_colony'
local shortrange_name = 'spore_colony_shortrange'

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
local base_acid_damage = 5
local incremental_acid_damage = 25

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 120
local incremental_attack_speed = 60

local attack_range = 30
local attack_shortrange = ERM_Config.get_max_attack_range()

-- Animation Settings
local unit_scale = 1.5

local folded_animation = function()
    return {
        layers = {
            {
                filename = "__erm_zerg__/graphics/entity/buildings/" .. name .. "/" .. name .. ".png",
                run_mode = "forward",
                width = 128,
                height = 128,
                frame_count = 4,
                direction_count = 1,
                scale = unit_scale,
            }
        }
    }
end

local integration_animation = function()
    return {
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
            },
        }
    }
end

function ErmZerg.make_spore_colony(level)
    level = level or 1

    data:extend({
        {
            type = "turret",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_zerg__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air" },
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
            folded_speed_secondary = 0.024,
            folded_animation = folded_animation(),
            working_sound = ZergSound.spore_idle(0.75),
            integration = integration_animation(),
            autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'biological',
                damage_modifier = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage, damage_multiplier, level),
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.25,
                warmup = 12,
                use_shooter_direction = true,
                lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5,
                sound = ZergSound.sunker_attack(0.75),
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "stream",
                            stream = "acid-stream-worm-behemoth",
                            source_offset = { 0.15, -0.5 }
                        }
                    }
                }
            }
        },
        {
            type = "turret",
            name = MOD_NAME .. '/' .. shortrange_name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. shortrange_name, level },
            icon = "__erm_zerg__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air" },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level) / 2,
            order = "b-c-c",
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
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level) / 2,
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
            folded_speed_secondary = 0.024,
            folded_animation = folded_animation(),
            working_sound = ZergSound.spore_idle(0.75),
            integration = integration_animation(),
            --autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'biological',
                damage_modifier = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage, damage_multiplier, level),
                range = attack_shortrange,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.25,
                warmup = 12,
                use_shooter_direction = true,
                lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5,
                sound = ZergSound.sunker_attack(0.75),
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "stream",
                            stream = "acid-stream-worm-behemoth",
                            source_offset = { 0.15, -0.5 }
                        }
                    }
                }
            }
        }
    })
end
---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 12:37 AM
---


local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local ERM_UnitTint = require("__enemyracemanager__/lib/rig/unit_tint")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local ERM_Config = require("__enemyracemanager__/lib/global_config")
local ZergSound = require("__erm_zerg__/prototypes/sound")


local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")


local enemy_autoplace = require ("__enemyracemanager__/prototypes/enemy-autoplace")
local name = "sunken_colony"
local short_range_name = "sunken_colony_shortrange"
-- Hitpoints

local hitpoint = 400
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value  * 2


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

local base_physical_damage = 1
local incremental_physical_damage = 14

-- Handles Attack Speed

local base_attack_speed = 120
local incremental_attack_speed = 60

-- Animation Settings
local unit_scale = 1.5

local folded_animation = function()
    return AnimationDB.get_layered_animations("buildings", name, "folded")
end

local attack_animation = function()
    return AnimationDB.get_layered_animations("buildings", name, "attack")
end

function ErmZerg.make_sunken_colony(level)
    level = level or 1

    local attack_range = ERM_UnitHelper.get_attack_range(level) + 16
    local shortrange_attack_range = ERM_UnitHelper.get_attack_range(level) + 1

    data:extend({
        {
            type = "turret",
            name = MOD_NAME .. "--" .. name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. name, tostring(level) },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "breaths-air" },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, max_hitpoint_multiplier,  level, true),
            order = MOD_NAME .. "--" .. name .. "--".. level,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup["erm_zerg-map-color"].value),
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
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier,  level),
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
            shooting_cursor_size = 4,
            rotation_speed = 1,
            corpse = MOD_NAME.."--small-base-corpse",
            dying_explosion = MOD_NAME.."--building-explosion-small",
            dying_sound = ZergSound.building_dying_sound(0.75),
            call_for_help_radius = 50,
            folded_speed = 0.01,
            folded_speed_secondary = 0.01,
            folded_animation = folded_animation(),
            graphics_set = {},
            working_sound = ZergSound.sunken_idle(0.75),
            starting_attack_animation = attack_animation(),
            starting_attack_speed = 0.02,
            starting_attack_sound = ZergSound.sunken_attack(0.75),
            autoplace = enemy_autoplace.enemy_worm_autoplace({
                probability_expression = "erm_zerg_autoplace_base(2, 1000013)",
                force = FORCE_NAME,
                control = AUTOCONTROL_NAME
            }),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = "biological",
                acceleration = 0,
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.25,
                warmup = 12,
                damage_modifier = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage,  level),
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
                                    entity_name = MOD_NAME.."--colony-explosion"
                                },
                                {
                                    type = "play-sound",
                                    sound = ZergSound.sunken_hit(0.75),
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
            name = MOD_NAME .. "--" .. short_range_name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. short_range_name, tostring(level) },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "breaths-air" },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, max_hitpoint_multiplier,  level, true),
            order = MOD_NAME .. "--" .. name .. "--".. level,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup["erm_zerg-map-color"].value),
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
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier,  level),
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
            shooting_cursor_size = 4,
            rotation_speed = 1,
            corpse = MOD_NAME.."--small-base-corpse",
            dying_explosion = MOD_NAME.."--building-explosion-small",
            dying_sound = ZergSound.building_dying_sound(0.75),
            call_for_help_radius = 50,
            folded_speed = 0.01,
            folded_speed_secondary = 0.01,
            folded_animation = folded_animation(),
            graphics_set = {},
            working_sound = ZergSound.sunken_idle(0.75),
            starting_attack_animation = attack_animation(),
            starting_attack_speed = 0.02,
            starting_attack_sound = ZergSound.sunken_attack(0.75),
            --autoplace = nil
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = "biological",
                acceleration = 0,
                range = shortrange_attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.25,
                warmup = 12,
                damage_modifier = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage,  level),
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
                                    entity_name = MOD_NAME.."--colony-explosion"
                                },
                                {
                                    type = "play-sound",
                                    sound = ZergSound.sunken_hit(0.75),
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
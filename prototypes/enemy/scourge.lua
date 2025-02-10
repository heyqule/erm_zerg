---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 7/15/2023 3:28 PM
---

--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--



local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ERMDataHelper = require("__enemyracemanager__/lib/rig/data_helper")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local ZergSound = require("__erm_zerg_hd_assets__/sound")
local biter_ai_settings = require ("__base__.prototypes.entity.biter-ai-settings")
local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local name = "scourge"


local hitpoint = 25
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 5


-- Handles acid and poison resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 50
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 80
-- Handles fire and explosive resistance
local base_fire_resistance = 10
local incremental_fire_resistance = 65
-- Handles laser and electric resistance
local base_electric_resistance = 0
local incremental_electric_resistance = 70
-- Handles cold resistance
local base_cold_resistance = 0
local incremental_cold_resistance = 70

-- Handles explosion damages

local base_explosion_damage = 0.5
local incremental_explosion_damage = 1.5

-- Handles Attack Speed

local base_attack_speed = 90
local incremental_attack_speed = 60

local attack_range = 1


local base_movement_speed = 0.3
local incremental_movement_speed = 0.3

-- Misc settings
local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)
local pollution_to_join_attack = 25
local distraction_cooldown = 300

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -0.75 }, { 0.75, 0.75 } }

function ErmZerg.make_scourge(level)
    level = level or 1

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. "--" .. name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. name, GlobalConfig.QUALITY_MAPPING[level] },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air" },
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, max_hitpoint_multiplier,  level),
            order = MOD_NAME .. "--unit--" .. name .. "--".. level,
            subgroup = "erm-flying-enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup["enemy_erm_zerg-map-color"].value),
            shooting_cursor_size = 2,
            min_pursue_time = 120 * second,
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
            collision_mask = ERMDataHelper.getFlyingCollisionMask(),
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed,  level),
            absorptions_to_join_attack = { pollution = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level)},
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            spawning_time_modifier = 1.5,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                range = attack_range,
                cooldown = 10,
                cooldown_deviation = 0.1,
                warmup = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                damage_modifier = ERM_UnitHelper.get_damage(base_explosion_damage, incremental_explosion_damage,  level),
                ammo_category = "biological",
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            source_effects =
                            {
                                {
                                    type = "script",
                                    effect_id = SELF_DESTRUCT_ATTACK,
                                },
                                {
                                    type = "create-entity",
                                    entity_name =  MOD_NAME.."--scourge-explosion"
                                },
                                {
                                    type = "nested-result",
                                    action = {
                                        type = "area",
                                        force = "not-same",
                                        radius = 3,
                                        ignore_collision_condition = true,
                                        action_delivery = {
                                            type = "instant",
                                            target_effects = {
                                                {
                                                    type = "damage",
                                                    damage = { amount = 100, type = "explosion" },
                                                    apply_damage_to_trees = true
                                                },
                                            }
                                        }
                                    }
                                },
                            },
                        }
                    },
                },
                sound = ZergSound.scourge_attack(0.9),
                animation = AnimationDB.get_layered_animations("units", name, "run")
            },
            render_layer = "wires-above",
            distance_per_frame = 0.32,
            run_animation = AnimationDB.get_layered_animations("units", name, "run"),
            created_effect = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    source_effects = {
                        {
                            type = "script",
                            effect_id = TIME_TO_LIVE_CREATED,
                        }
                    }
                }
            },
            dying_trigger_effect = {
                {
                    type = "script",
                    effect_id = TIME_TO_LIVE_DIED,
                },
            },
            dying_explosion = MOD_NAME .. "--" .. name .. "-air-death",
            dying_sound = ZergSound.enemy_death(name, 0.9),

            corpse = MOD_NAME .. "--" .. name .. "-corpse"
        },
        {
            type = "corpse",
            name = MOD_NAME .. "--" .. name .. "-corpse",
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = second,
            subgroup = "corpses",
            order = MOD_NAME .. "--" .. name .. level,
            animation = util.empty_sprite(),
        },
        {
            type = "explosion",
            name = MOD_NAME .. "--" .. name .. "-air-death",
            flags = { "not-on-map" },
            animations = AnimationDB.get_single_animation("units", name, "corpse"),
        }
    })
end

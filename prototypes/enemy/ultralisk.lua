--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--


local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local ZergSound = require("__erm_zerg__/prototypes/sound")
local biter_ai_settings = require ("__base__.prototypes.entity.biter-ai-settings")
local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local name = "ultralisk"


local hitpoint = 400
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.75


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
local incremental_electric_resistance = 90
-- Handles cold resistance
local base_cold_resistance = 0
local incremental_cold_resistance = 90

-- Handles physical damages

local base_physical_damage = 1
local incremental_physical_damage = 2

-- Handles Attack Speed

local base_attack_speed = 120
local incremental_attack_speed = 60

local attack_range = 1


local base_movement_speed = 0.2
local incremental_movement_speed = 0.075

-- Misc settings
local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)
local pollution_to_join_attack = 350
local distraction_cooldown = 300

-- Animation Settings
local unit_scale = 1.75

local collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
local selection_box = { { -1, -1 }, { 1, 1 } }

function ErmZerg.make_ultralisk(level)
    level = level or 1

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. "--" .. name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. name, GlobalConfig.QUALITY_MAPPING[level] },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", "not-flammable" },
            has_belt_immunity = true,
            max_health = ERM_UnitHelper.get_health(hitpoint, max_hitpoint_multiplier,  level),
            order = MOD_NAME .. "--"  .. name .. "--" .. level,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup["enemy_erm_zerg-map-color"].value),
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
            absorptions_to_join_attack = { pollution = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level)},
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            spawning_time_modifier = 2,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = "biological",
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                damage_modifier = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage,  level),
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "area",
                        radius = 3,
                        force = "not-same",
                        ignore_collision_condition = true,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = {
                                        amount = 50,
                                        type = "physical"
                                    },
                                    apply_damage_to_trees = true
                                }
                            }
                        }
                    }
                },
                sound = ZergSound.meele_attack(0.66),
                animation = AnimationDB.get_layered_animations("units", name, "attack")
            },
            distance_per_frame = 0.16,
            run_animation = AnimationDB.get_layered_animations("units", name, "run"),
            dying_explosion = "blood-explosion-small",
            dying_sound = ZergSound.enemy_death(name, 0.75),
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
            time_before_removed = minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
            subgroup = "corpses",
            order = MOD_NAME .. "--" .. name .. level,
            final_render_layer = "corpse",
            animation = AnimationDB.get_single_animation("units", name, "corpse"),
        }
    })
end
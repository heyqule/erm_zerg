--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--


local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ERMDataHelper = require("__enemyracemanager__/lib/rig/data_helper")
local ZergSound = require("__erm_zerg_hd_assets__/sound")
local biter_ai_settings = require ("__base__.prototypes.entity.biter-ai-settings")
local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local name = "queen"


local hitpoint = 120
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.75


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

-- Handles physical damages

local base_acid_damage = 5
local incremental_acid_damage = 15

-- Handles Attack Speed

local base_attack_speed = 600
local incremental_attack_speed = 300

local base_movement_speed = 0.25
local incremental_movement_speed = 0.2

-- Misc settings
local pollution_to_join_attack = 200
local distraction_cooldown = 300


local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -0.75 }, { 0.75, 0.75 } }

function ErmZerg.make_queen(level)
    level = level or 1
    local attack_range = ERM_UnitHelper.get_attack_range(level)
    local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. "--" .. name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. name, GlobalConfig.QUALITY_MAPPING[level] },
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", "not-flammable" },
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, max_hitpoint_multiplier,  level),
            order = MOD_NAME .. "--unit--" .. name .. "--".. level,
            subgroup = "erm-flying-enemies",
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
            collision_mask = ERMDataHelper.getFlyingCollisionMask(),
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
                range = attack_range,
                min_attack_distance = attack_range - 4,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level) - 30,
                cooldown_deviation = 0.1,
                warmup = 6,
                ammo_category = "biological",
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        {
                            type = "direct",
                            action_delivery = {
                                type = "projectile",
                                projectile = MOD_NAME.."--parasite-projectile",
                                starting_speed = 0.1,
                                max_range = GlobalConfig.get_max_projectile_range(),
                            }
                        },
                        {
                            type = "direct",
                            probability = 0.5,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "create-smoke",
                                        show_in_tooltip = true,
                                        entity_name = MOD_NAME .. "--acid-cloud-" .. level
                                    },
                                    {
                                        type = "create-explosion",
                                        entity_name = MOD_NAME.."--acid-cloud-explosion"
                                    }
                                }
                            }
                        }
                    },
                },
                sound = ZergSound.defiler_attack(0.9),
                lead_target_for_projectile_speed = 5,
                animation = AnimationDB.get_layered_animations("units", name, "attack")
            },
            render_layer = "wires-above",
            distance_per_frame = 0.32,
            run_animation = AnimationDB.get_layered_animations("units", name, "run"),
            dying_explosion = name .. "-air-death",
            dying_sound = ZergSound.enemy_death(name, 0.9),
            corpse = name .. "-corpse"
        },
        {
            type = "corpse",
            name = name .. "-corpse",
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = second,
            subgroup = "corpses",
            order = name,
            animation = util.empty_sprite(),
        },
        {
            type = "explosion",
            name = name .. "-air-death",
            flags = { "not-on-map" },
            animations = AnimationDB.get_single_animation("units", name, "corpse")
        },
        {
            name = MOD_NAME .. "--acid-cloud-" .. level,
            localised_name = {"entity-name.acid-cloud"},
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

            animation = util.empty_sprite(),
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "nested-result",
                            action = {
                                type = "area",
                                force = "not-same",
                                radius = 5,
                                ignore_collision_condition = true,
                                action_delivery = {
                                    type = "instant",
                                    target_effects = {
                                        {
                                          type = "damage",
                                          damage = { amount = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage,  level), type = "acid" }
                                        },
                                        {
                                            type = "create-sticker",
                                            sticker = "5-075-slowdown-sticker",
                                            show_in_tooltip = true,
                                        }
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

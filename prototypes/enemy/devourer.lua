--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--



local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local ERMDataHelper = require("__enemyracemanager__/lib/rig/data_helper")
local ZergSound = require("__erm_zerg__/prototypes/sound")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local biter_ai_settings = require ("__base__.prototypes.entity.biter-ai-settings")
local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local name = "devourer"

-- Hitpoints

local hitpoint = 250
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.15


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
local incremental_electric_resistance = 85
-- Handles cold resistance
local base_cold_resistance = 15
local incremental_cold_resistance = 70

-- Handles damages

local base_acid_damage = 10
local incremental_acid_damage = 30

-- Handles Attack Speed

local base_attack_speed = 180
local incremental_attack_speed = 90



local base_movement_speed = 0.2
local incremental_movement_speed = 0.15

-- Misc Settings
local pollution_to_join_attack = 100
local distraction_cooldown = 300

-- Animation Settings
local unit_scale = 1.3

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -1.25 }, { 0.75, 1.25 } }

function ErmZerg.make_devourer(level)
    level = level or 1
    local attack_range = ERM_UnitHelper.get_attack_range(level, 0.75)
    local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)

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
            subgroup = "erm-flying-enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup["erm_zerg-map-color"].value),
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
            spawning_time_modifier = 1.5,
            attack_parameters = {
                type = "stream",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = "biological",
                range = attack_range,
                min_attack_distance = attack_range - 3,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                ammo_type = {
                    category = "biological",
                    action = {
                        {
                            type = "direct",
                            probability = 0.25,
                            action_delivery = {
                                type = "instant",
                                source_effects = {
                                    type = "script",
                                    effect_id = SCOURGE_SPAWN,
                                }
                            }
                        },
                        {
                            type = "direct",
                            action_delivery = {
                                type = "stream",
                                stream = MOD_NAME .. "--" .. name .. "-stream-" .. level,
                            }
                        }
                    }
                },
                cyclic_sound = {
                    begin_sound = ZergSound.devourer_attack(0.66),
                },
                animation =  AnimationDB.get_layered_animations("units", name, "attack")
            },
            render_layer = "wires-above",
            distance_per_frame = 0.5,
            run_animation = AnimationDB.get_layered_animations("units", name, "attack"),
            dying_explosion = MOD_NAME .. "--" .. name .. "-air-death",
            dying_sound = ZergSound.enemy_death(name, 0.75),
            corpse = MOD_NAME .. "--" .. name .. "-corpse"
        },
        {
            type = "explosion",
            name = MOD_NAME .. "--" .. name .. "-air-death",
            flags = { "not-on-map" },
            animations = AnimationDB.get_single_animation("units", name, "corpse")
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
            type = "stream",
            name = MOD_NAME .. "--" .. name .. "-stream-" .. level,
            flags = { "not-on-map" },
            particle_spawn_interval = 1,
            particle_spawn_timeout = 6,
            particle_vertical_acceleration = 0.005 * 0.60 * 1.5,
            particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5,
            particle_horizontal_speed_deviation = 0,
            render_layer = "projectile",
            initial_action = {
                {
                    type = "direct",
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "create-smoke",
                                show_in_tooltip = true,
                                entity_name = MOD_NAME .. "--devourer-cloud-" .. level
                            },
                            {
                                type = "create-explosion",
                                entity_name = MOD_NAME.."--devourer-cloud-explosion"
                            },
                            {
                                type = "play-sound",
                                sound = ZergSound.devourer_hit(0.66)
                            },
                        }
                    }
                },
            },
            particle = AnimationDB.get_layered_animations("projectiles", name, "projectile")
        },
        {
            name = MOD_NAME .. "--devourer-cloud-" .. level,
            localised_name = {"entity-name.blood-cloud"},
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
            duration = 60,
            cyclic = true,
            --spread_duration = 20,

            animation = util.empty_sprite(),
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "nested-result",
                        action = {
                            type = "area",
                            force = "not-same",
                            radius = 1,
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "damage",
                                        damage = { amount = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage,  level), type = "acid" },
                                        apply_damage_to_trees = true
                                    },
                                    {
                                        type = "create-sticker",
                                        sticker = "5-050-slowdown-sticker",
                                        show_in_tooltip = true,
                                    }
                                }
                            }
                        }
                    }
                }
            },
            action_cooldown = 20
        },
    })
end

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
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ZergSound = require("__erm_zerg_hd_assets__/sound")
local biter_ai_settings = require ("__base__.prototypes.entity.biter-ai-settings")
local AnimationDB = require("__erm_zerg_hd_assets__/animation_db")
local name = "mutalisk"

-- Hitpoints

local hitpoint = 120
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.25


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

-- Handles damages

local base_acid_damage = 1
local incremental_acid_damage = 5

-- Handles Attack Speed

local base_movement_speed = 0.3
local incremental_movement_speed = 0.3

-- Misc Settings
local pollution_to_join_attack = 50
local distraction_cooldown = 300


local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -0.75 }, { 0.75, 0.75 } }

function ErmZerg.make_mutalisk(level)
    level = level or 1
    local attack_range = ERM_UnitHelper.get_attack_range(level, 0.5)
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
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = "biological",
                range = attack_range,
                min_attack_distance = attack_range - 3,
                cooldown = 15,
                damage_modifier = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage,  level),
                ammo_type = {
                    category = "biological",
                    target_type = "direction",
                    action = {
                        {
                            type = "direct",
                            action_delivery = {
                                type = "projectile",
                                projectile = MOD_NAME.."--mutalisk-projectile",
                                starting_speed = 0.3,
                                max_range = GlobalConfig.get_max_projectile_range(),
                            }                            
                        },
                        {
                            type = "direct",
                            action_delivery = {
                                type = "instant",
                                source_effects = {
                                    type = "script",
                                    effect_id = GUERRILLA_ATTACK,
                                }
                            }
                        }
                    }
                },
                sound = ZergSound.mutalisk_attack(0.9),
                animation = AnimationDB.get_layered_animations("units", name, "run")
            },
            render_layer = "wires-above",
            distance_per_frame = 0.64,
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
    })
end

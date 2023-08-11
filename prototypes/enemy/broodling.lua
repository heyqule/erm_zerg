--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ZergSound = require('__erm_zerg__/prototypes/sound')
local name = 'broodling'


local hitpoint = 30
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 3


-- Handles acid and poison resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 70
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 95
-- Handles fire and explosive resistance
local base_fire_resistance = 15
local incremental_fire_resistance = 80
-- Handles laser and electric resistance
local base_electric_resistance = 0
local incremental_electric_resistance = 90
-- Handles cold resistance
local base_cold_resistance = 0
local incremental_cold_resistance = 90

-- Handles physical damages

local base_physical_damage = 1
local incremental_physical_damage = 4

-- Handles Attack Speed

local base_attack_speed = 60
local incremental_attack_speed = 30

local attack_range = 1


local base_movement_speed = 0.175
local incremental_movement_speed = 0.075

-- Misc settings
local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)

local pollution_to_join_attack = 5
local distraction_cooldown = 300

-- Animation Settings
local unit_scale = 1.3

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

function ErmZerg.make_broodling(level)
    level = level or 1

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air" },
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. '/'  .. name .. '/' .. level,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_zerg-map-color'].value),
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
            pollution_to_join_attack = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level),
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            min_pursue_time = 120 * defines.time.second,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                damage_modifier = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage,  level),
                ammo_type = make_unit_melee_ammo_type(8),
                sound = ZergSound.broodling_attack(0.5),
                animation = {
                    layers = {
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 48,
                            height = 48,
                            frame_count = 5,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.5
                        },
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 48,
                            height = 48,
                            frame_count = 5,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            draw_as_shadow = true,
                            tint = ERM_UnitTint.tint_shadow(),
                            animation_speed = 0.5,
                            shift = {0.2, 0}
                        }
                    }
                }
            },

            distance_per_frame = 0.2,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 48,
                        height = 48,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 48,
                        height = 48,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        draw_as_shadow = true,
                        animation_speed = 1,
                        shift = {0.2, 0}
                    }
                }
            },
            dying_sound = ZergSound.enemy_death(name, 0.75),
            corpse = MOD_NAME .. "/" ..name .. '-corpse'
        },
        {
            type = "corpse",
            name = MOD_NAME .. "/" ..name .. '-corpse',
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,

            subgroup = "corpses",
            order = MOD_NAME .. "/" .. name .. level,
            final_render_layer = "corpse",
            animation = {
                filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-death.png",
                width = 48,
                height = 48,
                frame_count = 1,
                direction_count = 1,
                axially_symmetrical = false,
                scale = unit_scale,
                animation_speed = 0.2
            },
        }
    })
end

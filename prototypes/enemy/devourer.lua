--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ZergSound = require('__erm_zerg__/prototypes/sound')
local name = 'devourer'

-- Hitpoints
local health_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local hitpoint = 250
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.25

local resistance_mutiplier = settings.startup["enemyracemanager-level-multipliers"].value
-- Handles acid and poison resistance
local base_acid_resistance = 25
local incremental_acid_resistance = 65
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 90
-- Handles fire and explosive resistance
local base_fire_resistance = 15
local incremental_fire_resistance = 75
-- Handles laser and electric resistance
local base_electric_resistance = 0
local incremental_electric_resistance = 90
-- Handles cold resistance
local base_cold_resistance = 25
local incremental_cold_resistance = 65

-- Handles damages
local damage_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_acid_damage = 25
local incremental_acid_damage = 60

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 300
local incremental_attack_speed = 120

local attack_range = 12

local movement_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_movement_speed = 0.225
local incremental_movement_speed = 0.05

-- Misc Settings
local vision_distance = 45
local pollution_to_join_attack = 100
local distraction_cooldown = 20

-- Animation Settings
local unit_scale = 1.3

local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -1.25 }, { 0.75, 1.25 } }

function ErmZerg.make_devourer(level)
    level = level or 1
    if DEBUG_MODE then
        ERM_DebugHelper.print_translate_to_console(MOD_NAME, name, level)
    end

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. '-' .. name .. '-' .. level,
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,

            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air", 'not-flammable' },
            has_belt_immunity = true,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = "erm-" .. name .. '-' .. level,
            subgroup = "enemies",
            shooting_cursor_size = 2,
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
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
            collision_mask = {},
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed, movement_multiplier, level),
            pollution_to_join_attack = pollution_to_join_attack,
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            attack_parameters = {
                type = "stream",
                ammo_category = 'biological',
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.1,
                warmup = 12,
                ammo_type = {
                    category = "biological",
                    action =
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "stream",
                            stream = name .. "-stream" .. level,
                        }
                    }
                },
                cyclic_sound =
                {
                    begin_sound = ZergSound.devourer_attack(0.75),
                },
                animation = {
                    layers = {
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                            width = 96,
                            height = 96,
                            frame_count = 5,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.2,
                            run_mode = 'forward-then-backward'
                        },
                        {
                            filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run-mask.png",
                            width = 96,
                            height = 96,
                            frame_count = 5,
                            axially_symmetrical = false,
                            direction_count = 16,

                            scale = unit_scale,
                            tint = ERM_UnitTint.tint_shadow(),
                            animation_speed = 0.2,
                            run_mode = 'forward-then-backward',
                            draw_as_shadow = true,
                            shift = { 4, 0 }

                        }
                    }
                }
            },
            render_layer = "air-object",
            final_render_layer = "air-object",
            distance_per_frame = 0.5,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 96,
                        height = 96,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 0.6,
                        run_mode = 'forward-then-backward'
                    },
                    {
                        filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-run-mask.png",
                        width = 96,
                        height = 96,
                        frame_count = 5,
                        axially_symmetrical = false,
                        direction_count = 16,

                        scale = unit_scale,
                        tint = ERM_UnitTint.tint_shadow(),
                        shift = { 4, 0 },
                        animation_speed = 0.6,
                        draw_as_shadow = true,
                        run_mode = 'forward-then-backward'
                    }
                }
            },
            dying_explosion = "blood-explosion-small",
            dying_sound = ZergSound.enemy_death(name, 0.75),
            corpse = name .. '-corpse'
        },
        {
            type = "corpse",
            name = name .. '-corpse',
            icon = "__erm_zerg__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,

            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = defines.time.second * 5,
            subgroup = "corpses",
            order = "x" .. name .. level,
            final_render_layer = "lower-object-above-shadow",
            animation = {
                filename = "__erm_zerg__/graphics/entity/units/" .. name .. "/" .. name .. "-death.png",
                width = 140,
                height = 140,
                frame_count = 9,
                direction_count = 1,
                axially_symmetrical = false,
                scale = unit_scale * 1.5,
                animation_speed = 0.1
            },
            final_render_layer = "lower-object-above-shadow"
        },
        {
            type = "stream",
            name = name .. "-stream" .. level,
            flags = { "not-on-map" },
            particle_spawn_interval = 1,
            particle_spawn_timeout = 6,
            particle_vertical_acceleration = 0.005 * 0.60 * 1.5,
            particle_horizontal_speed = 0.2 * 0.75 * 1.5 * 1.5,
            particle_horizontal_speed_deviation = 0,
            render_layer = 'projectile',
            initial_action =
            {
                {
                    type = "direct",
                    action_delivery =
                    {
                        type = "instant",
                        target_effects =
                        {
                            {
                                type = "create-fire",
                                entity_name = name .. "-fire-" .. level,
                                tile_collision_mask = { "water-tile" },
                                show_in_tooltip = true
                            },
                            {
                                type = "play-sound",
                                sound = ZergSound.devourer_hit(0.75)
                            }
                        }
                    }
                },
            },
            particle =
            {
                filename = "__erm_zerg__/graphics/entity/projectiles/" .. name .. "_puke.png",
                width = 80,
                height = 80,
                frame_count = 4,
                axially_symmetrical = false,
                direction_count = 16,
                animation_speed = 0.2,
                run_mode = 'forward-then-backward',
            }
        },
        {
            type = "fire",
            name = name .. "-fire-" .. level,
            flags = { "not-on-map" },
            damage_per_tick = { amount = (ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage, damage_multiplier, level) / defines.time.second), type = "acid" },
            maximum_damage_multiplier = 3,
            damage_multiplier_increase_per_added_fuel = 1,
            damage_multiplier_decrease_per_tick = 1 / defines.time.second,
            limit_overlapping_particles = true,
            maximum_spread_count = 0,
            spread_delay = 0,
            spread_delay_deviation = 0,
            emissions_per_second = 0,
            initial_lifetime = 60,
            maximum_lifetime = 60,
            initial_flame_count = 1,
            burnt_patch_lifetime = 0,
            render_layer = 'projectile',
            pictures =
            {
                {
                    filename = "__erm_zerg__/graphics/entity/projectiles/" .. name .. "_puke_hit.png",
                    priority = "extra-high",
                    width = 56,
                    height = 56,
                    frame_count = 16,
                    animation_speed = 0.2,
                    scale = 1.5
                }
            },
        }
    })
end

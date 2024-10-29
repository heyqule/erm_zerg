---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/23/2020 11:29 PM
---
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ZergSound = require('__erm_zerg__/prototypes/sound')

local CreepFunction = require('__erm_zerg__/prototypes/creep_function')
local AnimationDB = require('__erm_zerg_hd_assets__/animation_db')
local enemy_autoplace = require ('__enemyracemanager__/prototypes/enemy-autoplace')
local name = 'spire'

-- Hitpoints

local hitpoint = 600
local max_hitpoint_multiplier = settings.startup['enemyracemanager-max-hitpoint-multipliers'].value


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

-- Animation Settings
local unit_scale = 2

local pollution_absorption_absolute = 50
local spawning_cooldown = { 600, 300 }
local spawning_radius = 10
local max_count_of_owned_units = 12
local max_friends_around_to_spawn = 7
local spawn_table = function(level)
    local res = {}
    res[1] = { MOD_NAME .. '--zergling--' .. level, { { 0.0, 0.7 }, { 0.2, 0.5 }, { 0.4, 0.4 }, { 0.6, 0.0 }, { 0.8, 0.0 }, {1.0, 0} } }
    res[2] = { MOD_NAME .. '--hydralisk--' .. level, { { 0.0, 0.3 }, { 0.2, 0.5 }, { 0.4, 0.4 }, { 0.6, 0.5 }, { 0.8, 0.2 }, {1.0, 0} } }
    res[3] = { MOD_NAME .. '--mutalisk--' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.2 }, { 0.6, 0.3 }, { 0.8, 0.5 }, {1.0, 0.4} } }
    res[4] = { MOD_NAME .. '--guardian--' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, {1.0, 0.2} } }
    res[5] = { MOD_NAME .. '--devourer--' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.15 }, {1.0, 0.3} } }
    res[6] = { MOD_NAME .. '--overlord--' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.15 }, {1.0, 0.1} } }
    return res
end

local collision_box = { { -3, -3.75 }, { 3.25, 2.75 } }
local map_generator_bounding_box = { { -4, -4.75 }, { 4.25, 3.75 } }
local selection_box = { { -3, -3.75 }, { 3.25, 3 } }

function ErmZerg.make_spire(level)
    level = level or 1

    data:extend({
        {
            type = 'unit-spawner',
            name = MOD_NAME .. '--' .. name .. '--' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '--' .. name, tostring(level) },
            icon = '__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png',
            icon_size = 64,
            flags = { 'placeable-player', 'placeable-enemy', 'breaths-air' },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. '--' .. name .. '--'.. level,
            subgroup = 'enemies',
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_zerg-map-color'].value),
            working_sound = ZergSound.building_working_sound(name, 0.75),
            dying_sound = ZergSound.building_dying_sound(0.75),
            resistances = {
                { type = 'acid', percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = 'poison', percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = 'physical', percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance,  level) },
                { type = 'fire', percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = 'explosion', percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = 'laser', percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = 'electric', percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = 'cold', percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance,  level) }
            },
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier,  level),
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
    absorptions_per_second = { pollution = { absolute = pollution_absorption_absolute, proportional = 0.01 } },
            corpse = MOD_NAME..'--small-base-corpse',
            dying_explosion = MOD_NAME..'--building-explosion',
            max_count_of_owned_units = max_count_of_owned_units,
	            max_friends_around_to_spawn = max_friends_around_to_spawn,
            graphics_set = {
                animations = AnimationDB.get_layered_animations('buildings', name, 'run')
            },
            result_units = spawn_table(level),
            -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
            spawning_cooldown = spawning_cooldown,
            spawning_radius = spawning_radius,
            spawning_spacing = 3,
            max_spawn_shift = 0,
            max_richness_for_spawn_shift = 100,
            -- distance_factor used to be 1, but Twinsen says:
            -- 'The number or spitter spwners should be roughly equal to the number of biter spawners(regardless of difficulty).'
            -- (2018-12-07)
           autoplace = enemy_autoplace.enemy_spawner_autoplace('enemy_autoplace_base(0, 20011)', FORCE_NAME),
            call_for_help_radius = 50,
            spawn_decorations_on_expansion = true,
            spawn_decoration =  CreepFunction.getSpawnerCreep(),
        }
    })
end
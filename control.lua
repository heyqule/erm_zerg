--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local Game = require('__stdlib__/stdlib/game')

local ErmConfig = require('__enemyracemanager__/lib/global_config')
local ErmForceHelper = require('__enemyracemanager__/lib/helper/force_helper')
local ErmRaceSettingsHelper = require('__enemyracemanager__/lib/helper/race_settings_helper')

local Event = require('__stdlib__/stdlib/event/event')
local String = require('__stdlib__/stdlib/utils/string')
local CustomAttacks = require('__erm_zerg__/prototypes/custom_attacks')

require('__erm_zerg__/global')
-- Constants


local createRace = function()
    local force = game.forces[FORCE_NAME]
    if not force then
        force = game.create_force(FORCE_NAME)
    end

    force.ai_controllable = true;
    force.disable_research()
    force.friendly_fire = false;

    if settings.startup['enemyracemanager-free-for-all'].value then
        ErmForceHelper.set_friends(game, FORCE_NAME, false)
    else
        ErmForceHelper.set_friends(game, FORCE_NAME, true)
    end
end

local addRaceSettings = function()
    if remote.call('enemy_race_manager', 'get_race', MOD_NAME) then
        return
    end
    local race_settings = {
        race = MOD_NAME,
        version = MOD_VERSION,
        level = 1, -- Race level
        tier = 1, -- Race tier
        evolution_point = 0,
        evolution_base_point = 0,
        attack_meter = 0, -- Build by killing their force (Spawner = 50, turrets = 10, unit = 1)
        next_attack_threshold = 0, -- Used by system to calculate next move
        units = {
            { 'zergling', 'hydralisk' },
            { 'overlord', 'devourer', 'drone', 'mutalisk', 'lurker' },
            { 'guardian', 'ultralisk', 'queen', 'infested', 'defiler' },
        },
        current_units_tier = {},
        turrets = {
            { 'sunker_colony', 'spore_colony' },
            {},
            {},
        },
        current_turrets_tier = {},
        command_centers = {
            { 'hatchery' },
            { 'lair' },
            { 'hive' }
        },
        current_command_centers_tier = {},
        support_structures = {
            { 'spawning_pool', 'hydraden', 'spire', 'chamber' },
            { 'greater_spire' },
            { 'ultralisk_cavern', 'queen_nest', 'defiler_mound', 'nyduspit' },
        },
        current_support_structures_tier = {},
        flying_units = {
            {'mutalisk'}, -- Fast unit that uses in rapid target attack group
            {'devourer'},
            {'guardian','queen'}
        },
        dropship = 'overlord'
    }

    race_settings.current_units_tier = race_settings.units[1]
    race_settings.current_turrets_tier = race_settings.turrets[1]
    race_settings.current_command_centers_tier = race_settings.command_centers[1]
    race_settings.current_support_structures_tier = race_settings.support_structures[1]

    remote.call('enemy_race_manager', 'register_race', race_settings)
end

Event.on_init(function(event)
    createRace()
    addRaceSettings()
end)

Event.on_load(function(event)
end)

Event.on_configuration_changed(function(event)
    createRace()

    -- Mod Compatibility Upgrade for race settings
    Event.dispatch({
        name = Event.get_event_name(ErmConfig.RACE_SETTING_UPDATE), affected_race = MOD_NAME })
end)

Event.register(defines.events.on_script_trigger_effect, function(event)
    if not event.source_entity or
            String.find(event.source_entity.name, MOD_NAME, 1, true) == nil
    then
        return
    end

    if event.effect_id == OVERLORD_ATTACK then
        CustomAttacks.process_overlord(event)
    elseif event.effect_id == DRONE_ATTACK then
        CustomAttacks.process_drone(event)
    elseif event.effect_id == INFESTED_ATTACK then
        CustomAttacks.process_infested(event)
    end
end)

---
--- Modify Race Settings for existing game
---
Event.register(Event.generate_event_name(ErmConfig.RACE_SETTING_UPDATE), function(event)
    local race_setting = remote.call('enemy_race_manager', 'get_race', MOD_NAME)
    if (event.affected_race == MOD_NAME) and race_setting then
        if race_setting.version < MOD_VERSION then
            if race_setting.version < 101 then
                race_setting.angry_meter = nil
                race_setting.send_attack_threshold = nil
                race_setting.send_attack_threshold_deviation = nil
                race_setting.attack_meter = 0

                ErmRaceSettingsHelper.remove_unit_from_tier(race_setting, 1, 'mutalisk')
                ErmRaceSettingsHelper.add_unit_to_tier(race_setting, 2, 'mutalisk')
                ErmRaceSettingsHelper.add_unit_to_tier(race_setting, 2, 'lurker')

                race_setting.flying_units = {
                    {'mutalisk'}, -- Fast unit that uses in rapid target attack group
                    {'devourer'}, -- Overlap Tier to increase spawn rate
                    {'guardian','queen'}
                }
                race_setting.dropship = 'overlord'
            end

            if race_setting.version < 102 then
                ErmRaceSettingsHelper.add_unit_to_tier(race_setting, 3, 'infested')
            end

            race_setting.version = MOD_VERSION
        end
        remote.call('enemy_race_manager', 'update_race_setting', race_setting)
    end
end)




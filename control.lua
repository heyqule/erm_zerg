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
    local race_settings = remote.call('enemy_race_manager', 'get_race', MOD_NAME)
    if race_settings == nil then
        race_settings = {}
    end

    race_settings.race =  race_settings.race or MOD_NAME
    race_settings.version =  race_settings.version or MOD_VERSION
    race_settings.level =  race_settings.level or 1
    race_settings.tier =  race_settings.tier or 1
    race_settings.evolution_point =  race_settings.evolution_point or 0
    race_settings.evolution_base_point =  race_settings.evolution_base_point or 0
    race_settings.attack_meter = race_settings.attack_meter or 0
    race_settings.attack_meter_total = race_settings.attack_meter_total or 0
    race_settings.next_attack_threshold = race_settings.next_attack_threshold or 0

    race_settings.units = {
        { 'zergling', 'hydralisk' },
        { 'overlord', 'devourer', 'drone', 'mutalisk', 'lurker' },
        { 'guardian', 'ultralisk', 'queen', 'infested', 'defiler' },
    }
    race_settings.turrets = {
        { 'sunker_colony', 'spore_colony' },
        {},
        {},
    }
    race_settings.command_centers = {
        { 'hatchery' },
        { 'lair' },
        { 'hive' }
    }
    race_settings.support_structures = {
        { 'spawning_pool', 'hydraden', 'spire', 'chamber' },
        { 'greater_spire' },
        { 'ultralisk_cavern', 'queen_nest', 'defiler_mound', 'nyduspit' },
    }
    race_settings.flying_units = {
        {'mutalisk'}, -- Fast unit that uses in rapid target attack group
        {'devourer'},
        {'guardian','queen'}
    }
    race_settings.dropship = 'overlord'

    remote.call('enemy_race_manager', 'register_race', race_settings)

    Event.dispatch({
        name = Event.get_event_name(ErmConfig.RACE_SETTING_UPDATE), affected_race = MOD_NAME })
end

Event.on_init(function(event)
    createRace()
    addRaceSettings()
end)

Event.on_load(function(event)
end)

Event.on_configuration_changed(function(event)
    createRace()
    addRaceSettings()
end)

local attack_functions = {
    [OVERLORD_ATTACK] = function(args)
        CustomAttacks.process_overlord(args)
    end,
    [DRONE_ATTACK] = function(args)
        CustomAttacks.process_drone(args)
    end,
    [INFESTED_ATTACK] = function(args)
        CustomAttacks.process_infested(args)
    end,
}
Event.register(defines.events.on_script_trigger_effect, function(event)
    if  attack_functions[event.effect_id] and
        CustomAttacks.valid(event, MOD_NAME)
    then
        attack_functions[event.effect_id](event)
    end
end)




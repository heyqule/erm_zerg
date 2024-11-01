--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local Game = require("__stdlib__/stdlib/game")

local ErmConfig = require("__enemyracemanager__/lib/global_config")
local ErmForceHelper = require("__enemyracemanager__/lib/helper/force_helper")
local ErmRaceSettingsHelper = require("__enemyracemanager__/lib/helper/race_settings_helper")

local Event = require("__stdlib__/stdlib/event/event")
local String = require("__stdlib__/stdlib/utils/string")
local CustomAttacks = require("__erm_zerg__/scripts/custom_attacks")

require("__erm_zerg__/global")
-- Constants

---
--- Enemy Force initialization.
---
local createRace = function()
    local force = game.forces[FORCE_NAME]
    if not force then
        force = game.create_force(FORCE_NAME)
    end

    force.ai_controllable = true;
    force.disable_research()
    force.friendly_fire = false;

    if settings.startup["enemyracemanager-free-for-all"].value then
        ErmForceHelper.set_friends(game, FORCE_NAME, false)
    else
        ErmForceHelper.set_friends(game, FORCE_NAME, true)
    end

    ErmForceHelper.set_neutral_force(game, FORCE_NAME)
end

---
--- Enemy race setting registration.
---
local addRaceSettings = function()
    local race_settings = remote.call("enemyracemanager", "get_race", MOD_NAME)
    if race_settings == nil then
        race_settings = {}
    end

    race_settings.race =  race_settings.race or MOD_NAME
    race_settings.label = {"gui.label-erm-zerg"}
    race_settings.level =  race_settings.level or 1
    race_settings.tier =  race_settings.tier or 1
    race_settings.evolution_point =  race_settings.evolution_point or 0
    race_settings.evolution_base_point =  race_settings.evolution_base_point or 0
    race_settings.attack_meter = race_settings.attack_meter or 0
    race_settings.attack_meter_total = race_settings.attack_meter_total or 0
    race_settings.last_attack_meter_total = race_settings.last_attack_meter_total or 0
    race_settings.next_attack_threshold = race_settings.next_attack_threshold or 0

    --- Units here will used for calculating attack point and level evolution
    --- It should not include timed units and units spawned by other units.
    race_settings.units = {
        { "zergling", "hydralisk" },
        { "overlord", "devourer", "drone", "mutalisk", "lurker" },
        { "guardian", "ultralisk", "queen", "infested", "defiler" },
    }
    race_settings.turrets = {
        { "sunken_colony", "spore_colony" },
        {},
        {},
    }
    race_settings.command_centers = {
        { "hatchery" },
        { "lair" },
        { "hive" }
    }
    race_settings.support_structures = {
        { "spawning_pool", "hydraden", "spire", "chamber" },
        { "greater_spire" },
        { "ultralisk_cavern", "queen_nest", "defiler_mound", "nyduspit" },
    }
    race_settings.flying_units = {
        {"mutalisk"},
        {"devourer"},
        {"guardian","queen"}
    }
    race_settings.timed_units = {
        scourge=true,
        broodling=true
    }
    race_settings.dropship = "overlord"
    race_settings.droppable_units = {
        {{ "hydralisk" },{1}},
        {{ "hydralisk", "lurker" },{2,1}},
        {{ "hydralisk", "lurker", "ultralisk" },{2,2,1}},
    }
    race_settings.construction_buildings = {
        {{ "sunken_colony_shortrange"},{1}},
        {{ "sunken_colony_shortrange"},{1}},
        {{ "sunken_colony_shortrange","nyduspit"},{2,1}},
    }
    race_settings.featured_groups = {
        -- Unit list, spawn ratio, unit attack point cost
        {{"zergling","ultralisk"}, {4, 2}, 25},
        {{"hydralisk","lurker", "ultralisk"}, {4, 2, 1}, 30},
        {{"zergling", "infested", "lurker", "ultralisk"}, {4, 1, 2, 2}, 25},
        {{"zergling","ultralisk","defiler"}, {6, 3, 1}, 30},
        {{"zergling", "hydralisk", "lurker", "ultralisk"}, {4, 2, 1, 1}, 25},
        {{"zergling", "hydralisk", "lurker", "ultralisk", "defiler"}, {3, 2, 1, 2, 1}, 20},
    }
    race_settings.featured_flying_groups = {
        {{"mutalisk"}, {1}, 50},
        {{"devourer", "guardian"}, {2, 1}, 75},
        {{"mutalisk", "devourer", "queen" }, {4,2,1}, 90},
        {{"mutalisk", "guardian", "overlord" }, {4,2,1}, 80},
        {{"mutalisk", "queen","devourer", "guardian"}, {4, 1, 2, 2}, 75},
    }

    race_settings.boss_building = "overmind"
    race_settings.pathing_unit = "zergling"
    race_settings.colliding_unit = "ultralisk"
    race_settings.boss_tier = race_settings.boss_tier or 1
    race_settings.boss_kill_count = race_settings.boss_kill_count or 0

    --if game.active_mods["Krastorio2"] then
    --    race_settings.enable_k2_creep = settings.startup["erm_zerg-k2-creep"].value
    --end

    remote.call("enemyracemanager", "register_race", race_settings)

    -- reload local cache
    CustomAttacks.get_race_settings(MOD_NAME, true)
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
    [OVERLORD_SPAWN] = function(args)
        CustomAttacks.process_overlord(args)
    end,
    [QUEEN_SPAWN] = function(args)
        CustomAttacks.process_queen(args)
    end,
    [DRONE_SPAWN] = function(args)
        CustomAttacks.process_drone(args)
    end,
    [SCOURGE_SPAWN] = function(args)
        CustomAttacks.process_scourge_spawn(args)
    end,
    [SELF_DESTRUCT_ATTACK] = function(args)
        CustomAttacks.process_self_destruct(args)
    end,
    [TIME_TO_LIVE_DIED] = function(args)
        CustomAttacks.process_time_to_live_unit_died(args)
    end,
    [TIME_TO_LIVE_CREATED] = function(args)
        CustomAttacks.process_time_to_live_unit_created(args)
    end,
    [BOSS_SPAWN_ATTACK] = function(args)
        CustomAttacks.process_boss_units(args)
    end,
    [UNITS_SPAWN_ATTACK] = function(args)
        CustomAttacks.process_batch_units(args)
    end
}
Event.register(defines.events.on_script_trigger_effect, function(event)
    if  attack_functions[event.effect_id] and
        CustomAttacks.valid(event, MOD_NAME)
    then
        attack_functions[event.effect_id](event)
    end
end)


Event.register(defines.events.on_segment_entity_created, function(event)
    -- Change demolish to zerg force, hmm.. doesn't look realistic when building survives
    --event.entity.force = FORCE_NAME

    -- @TODO track them Demolishers.  If they get attacked, they shits zergs
end)

---- Clear time to live unit every 15s.
Event.on_nth_tick(907, function(event)
    CustomAttacks.clear_time_to_live_units(event)
end)

---
--- Register required remote interfaces
---
local ErmBossAttack = require("scripts/boss_attacks")
---
--- Register boss attacks
--- Interface Name: {race_name}_boss_attacks
---
remote.add_interface("erm_zerg_boss_attacks", {
    get_attack_data = ErmBossAttack.get_attack_data,
})

---
--- Register the mod as new enemy mods and its additional settings
--- Interface Name: {race_name}
---
local RemoteApi = require("scripts/remote")
remote.add_interface("erm_zerg", RemoteApi)


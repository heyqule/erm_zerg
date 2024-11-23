--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local ForceHelper = require("__enemyracemanager__/lib/helper/force_helper")

local CustomAttacks = require("__erm_zerg__/scripts/custom_attacks")

require("__erm_zerg__/global")
-- Constants

local using_demolisher_nydus_worm = script.feature_flags.space_travel

local zerg_on_vulcanus = script.feature_flags.space_travel and settings.startup["enemy_erm_zerg-on_vulcanus"].value
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
    force.friendly_fire = true;

    if settings.startup["enemyracemanager-free-for-all"].value then
        ForceHelper.set_friends(game, FORCE_NAME, false)
    else
        ForceHelper.set_friends(game, FORCE_NAME, true)
    end

    ForceHelper.set_neutral_force(game, FORCE_NAME)

    --- store units created by demolisher for additional evil processing. :)
    storage.demolisher_units = storage.demolisher_units or {}
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
        {{"zergling", "mutalisk", "ultralisk", "defiler"}, {4, 2, 1, 1}, 30},
    }
    race_settings.featured_flying_groups = {
        {{"mutalisk"}, {1}, 50},
        {{"devourer", "guardian"}, {2, 1}, 75},
        {{"mutalisk", "devourer", "queen" }, {4,2,1}, 90},
        {{"mutalisk", "guardian", "overlord" }, {4,2,1}, 80},
        {{"mutalisk", "queen","devourer", "guardian"}, {4, 1, 2, 2}, 75},
        {{"overlord", "mutalisk"}, {1, 2}, 50 },
        {{"overlord", "mutalisk", "guardian"}, {1,3,2}, 50},
    }

    race_settings.boss_building = "overmind"
    --- used to do pathing.
    race_settings.pathing_unit = "zergling"
    --- used for collision checks. It's the largest ground unit.
    race_settings.colliding_unit = "ultralisk"
    race_settings.home_planet = "char"
    race_settings.boss_tier = race_settings.boss_tier or 1
    race_settings.boss_kill_count = race_settings.boss_kill_count or 0

    race_settings.structure_killed_count_by_planet = {}
    race_settings.unit_killed_count_by_planet = {}

    remote.call("enemyracemanager", "register_race", race_settings)

    -- reload local cache
    CustomAttacks.get_race_settings(MOD_NAME, true)
end

local update_world = function()
    --- Insert autoplace into existing vulcanus surface
    local vulcanus = game.surfaces["vulcanus"]
    if vulcanus and zerg_on_vulcanus
    then
        --- =_= map_gen_settings write only support writing the whole block.
        local map_gen = vulcanus.map_gen_settings
        map_gen.autoplace_controls[AUTOCONTROL_NAME] =
            vulcanus.planet.prototype.map_gen_settings.autoplace_controls[AUTOCONTROL_NAME]
        vulcanus.map_gen_settings = map_gen

        --- hmmm.. replacing the demolishers makes them spawn in explored area lol.  They don't follow the grid?
        local demolishers = { "small-demolisher","medium-demolisher","big-demolisher" }
        local entities = vulcanus.find_entities_filtered({name = demolishers })
        for _, entity in pairs(entities) do
            entity.force = FORCE_NAME
        end
    end
end

script.on_init(function(event)
    createRace()
    addRaceSettings()
    update_world()
end)

script.on_load(function(event)
end)

script.on_configuration_changed(function(event)
    createRace()
    addRaceSettings()
    update_world()
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
    end,
    [NYDUS_DEATH_ATTACK] = function(args)
        CustomAttacks.process_batch_units(args)
    end
}
script.on_event(defines.events.on_script_trigger_effect, function(event)
    if  attack_functions[event.effect_id] and
        CustomAttacks.valid(event, MOD_NAME)
    then
        attack_functions[event.effect_id](event)
    end
end)

local is_compatible_demolisher = {
    ["enemy_erm_zerg-small-demolisher"] =  true,
    ["enemy_erm_zerg-medium-demolisher"] =  true,
    ["enemy_erm_zerg-big-demolisher"] =  true,
}

local demolisher_name_filter = {
    "enemy_erm_zerg-small-demolisher","enemy_erm_zerg-medium-demolisher","enemy_erm_zerg-big-demolisher"
}

local on_trigger_created_entity_handlers = {
    ["segmented-unit"] = function(entity, source)
        if is_compatible_demolisher[source.name] then
            entity.force = FORCE_NAME
            local surface_name = entity.surface.name
            if storage.demolisher_units[surface_name] == nil then
                storage.demolisher_units[surface_name] = {}
            end

            storage.demolisher_units[surface_name][entity.unit_number] = {
                entity = entity,
                tick = game.tick
            }
        end

        if entity.commandable then
            entity.commandable.set_command({
                type =  defines.command.go_to_location,
                distraction = defines.distraction.by_anything,
                --- @TODO use attack beacon
                destination = {0, 0},
            })
        end
    end
}

script.on_event(defines.events.on_trigger_created_entity, function(event)
    local entity = event.entity
    local source = event.source
    if on_trigger_created_entity_handlers[source.type] and entity.valid then
        on_trigger_created_entity_handlers[source.type](entity, source)
    end
end)


script.on_event(defines.events.on_segment_entity_created, function(event)
    if is_compatible_demolisher[event.entity.name] then
        event.entity.force = FORCE_NAME
    end
end)

---- Clear time to live unit every 15s.
script.on_nth_tick(907, function(event)
    CustomAttacks.clear_time_to_live_units(event)

    if using_demolisher_nydus_worm then
        CustomAttacks.demolisher_units_attack()
    end
end)

--- Spawn attack group periodically once evolution reach 5%
script.on_nth_tick(9 * minute + 13, function(event)
    local vulcanus = game.surfaces['vulcanus']
    if vulcanus and zerg_on_vulcanus and CustomAttacks.can_spawn(33) then
        if game.forces[FORCE_NAME].get_evolution_factor(vulcanus) < 0.05 then
            return
        end

        local worms = vulcanus.find_entities_filtered {name = demolisher_name_filter, limit = 1}
        local key, worm = next(worms)
        if worm then
            if CustomAttacks.can_spawn(10) then
                remote.call("enemyracemanager", "generate_dropship_group", FORCE_NAME, 20, {surface=vulcanus})
            elseif CustomAttacks.can_spawn(33) then
                remote.call("enemyracemanager", "generate_flying_group", FORCE_NAME, 30, {surface=vulcanus})
            else
                remote.call("enemyracemanager", "generate_attack_group", FORCE_NAME, 60, {surface=vulcanus})
            end
        end
    end
end)

---
--- Register required remote interfaces
---
local BossAttack = require("scripts/boss_attacks")
---
--- Register boss attacks
--- Interface Name: {race_name}_boss_attacks
---
remote.add_interface("erm_zerg_boss_attacks", {
    get_attack_data = BossAttack.get_attack_data,
})

---
--- Register the mod as new enemy mods and its additional settings
--- Interface Name: {race_name}
---
local RemoteApi = require("scripts/remote")
remote.add_interface("erm_zerg", RemoteApi)


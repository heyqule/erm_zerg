--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local Game = require('__stdlib__/stdlib/game')

ErmConfig =  require('__enemyracemanager__/lib/global_config')

local Event = require('__stdlib__/stdlib/event/event')
local String = require('__stdlib__/stdlib/utils/string')
local CustomAttacks = require('__erm_zerg__/prototypes/custom_attacks')

require('__erm_zerg__/global')
-- Constants


local createZergRace = function()
    local zerg_force = game.forces[FORCE_NAME]
    if not zerg_force then
        zerg_force = game.create_force(FORCE_NAME)
    end
    zerg_force.ai_controllable = true;
    zerg_force.disable_research()
    zerg_force.friendly_fire = false;

    game.forces['enemy'].set_friend(zerg_force, true)
    game.forces[FORCE_NAME].set_friend(game.forces['enemy'], true)
end

local addRaceSettings = function()
    local race_settings = {
        race = MOD_NAME,
        version = MOD_VERSION,
        units = {
            tier_1 = {'zergling','hydralisk','mutalisk'},
            tier_2 = {'overlord','guardian','devourer','drone'},
            tier_3 = {'ultralisk','queen','defiler','overlord'},
        },
        turrets = {
            tier_1 = {'sunker','spore'},
            tier_2 = {'sunker','spore'},
            tier_3 = {'sunker','spore','nydus'},
        },
        command_centers = {
            tier_1 = {'hatchery'},
            tier_2 = {'lair'},
            tier_3 = {'hive'}
        },
        support_structures = {
            tier_1 = {'pool','hydraden','spire', 'chamber'},
            tier_2 = {'greater_spire'},
            tier_3 = {'ultralisk_carvern','queen_nest','defiler_mound'},
        }
    }
    if not remote.call('enemy_race_manager','get_race', MOD_NAME) then
        remote.call('enemy_race_manager','register_race', race_settings)
    end
end

Event.on_init(function(event)
    createZergRace()
    addRaceSettings()
end)

Event.on_load(function(event)

end)


Event.register(defines.events.on_script_trigger_effect, function (event)
    if not event.source_entity then
        print(event.source_entity)
        print(event.source_position.x)
        print(event.target_entity)
        print(event.target_position.x)
        print(event.effect_id)
        return
    end

    if event.effect_id == OVERLORD_ATTACK then
        CustomAttacks.process_overlord(event)
    elseif event.effect_id == DRONE_ATTACK then
        CustomAttacks.process_drone(event)
    end
end)


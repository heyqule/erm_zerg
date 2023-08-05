ErmZerg = {}

require('__erm_zerg__/global')

local ErmConfig = require('__enemyracemanager__/lib/global_config')

-- This set of data is used for set up default autoplace calculation.
data.erm_spawn_specs = data.erm_spawn_specs or {}
table.insert(data.erm_spawn_specs, {
    mod_name=MOD_NAME,
    force_name=FORCE_NAME,
    moisture=1, -- 1 = Dry and 2 = Wet
    aux=2, -- -- 1 = red desert, 2 = sand
    elevation=1, --1,2,3 (1 low elevation, 2. medium, 3 high elavation)
    temperature=3, --1,2,3 (1 cold, 2. normal, 3 hot)
})

require "prototypes/projectiles"
require "prototypes/boss-projectiles"

require "prototypes.enemy.zergling"
require "prototypes.enemy.mutalisk"
require "prototypes.enemy.hydralisk"
require "prototypes.enemy.ultralisk"
require "prototypes.enemy.devourer"
require "prototypes.enemy.guardian"
require "prototypes.enemy.overlord"
require "prototypes.enemy.lurker"
require "prototypes.enemy.drone"
require "prototypes.enemy.defiler"
require "prototypes.enemy.queen"
require "prototypes.enemy.infested"
require "prototypes.enemy.broodling"
require "prototypes.enemy.scourge"

require "prototypes.building.building_death"
require "prototypes.building.hydraden"
require "prototypes.building.spawning_pool"
require "prototypes.building.hatchery"
require "prototypes.building.lair"
require "prototypes.building.hive"
require "prototypes.building.boss_overmind"
require "prototypes.building.spore_colony"
require "prototypes.building.sunker_colony"
require "prototypes.building.chamber"
require "prototypes.building.spire"
require "prototypes.building.greater_spire"
require "prototypes.building.queen_nest"
require "prototypes.building.defiler_mound"
require "prototypes.building.ultralisk_cavern"
require "prototypes.building.nyduspit"
require "prototypes.building.infested_cmd"

local max_level = ErmConfig.MAX_LEVELS

for i = 1, max_level + ErmConfig.MAX_ELITE_LEVELS do
    ErmZerg.make_zergling(i)
    ErmZerg.make_hydralisk(i)
    ErmZerg.make_mutalisk(i)
    ErmZerg.make_ultralisk(i)
    ErmZerg.make_devourer(i)
    ErmZerg.make_guardian(i)
    ErmZerg.make_overlord(i)
    ErmZerg.make_lurker(i)
    ErmZerg.make_drone(i)
    ErmZerg.make_defiler(i)
    ErmZerg.make_queen(i)
    ErmZerg.make_infested(i)
    ErmZerg.make_broodling(i)
    ErmZerg.make_scourge(i)
end

local boss_level = ErmConfig.BOSS_LEVELS

local boss_unit_ai = { destroy_when_commands_fail = true, allow_try_return_to_spawner = false }
local override_units = {'zergling','hydralisk','mutalisk','devourer','guardian','overlord','lurker','drone','defiler','queen','infested','ultralisk'}

for i = 1, #boss_level do
    local level = boss_level[i]
    ErmZerg.make_zergling(level)
    ErmZerg.make_hydralisk(level)
    ErmZerg.make_mutalisk(level)
    ErmZerg.make_ultralisk(level)
    ErmZerg.make_devourer(level)
    ErmZerg.make_guardian(level)
    ErmZerg.make_overlord(level)
    ErmZerg.make_lurker(level)
    ErmZerg.make_drone(level)
    ErmZerg.make_defiler(level)
    ErmZerg.make_queen(level)
    ErmZerg.make_infested(level)
    ErmZerg.make_broodling(level)
    ErmZerg.make_scourge(level)

    ErmZerg.make_boss_hive(level, ErmConfig.BOSS_BUILDING_HITPOINT[i])

    for _, unit in pairs(override_units) do
        data.raw['unit'][MOD_NAME..'/'..unit..'/'..level]['ai_settings'] = boss_unit_ai
    end
end

for i = 1, max_level do
    ErmZerg.make_hatchery(i)
    ErmZerg.make_lair(i)
    ErmZerg.make_hive(i)
    ErmZerg.make_hydraden(i)
    ErmZerg.make_spawning_pool(i)
    ErmZerg.make_chamber(i)
    ErmZerg.make_spire(i)
    ErmZerg.make_greater_spire(i)
    ErmZerg.make_defiler_mound(i)
    ErmZerg.make_queen_nest(i)
    ErmZerg.make_ultralisk_cavern(i)
    ErmZerg.make_nyduspit(i)
    ErmZerg.make_spore_colony(i)
    ErmZerg.make_sunker_colony(i)
    ErmZerg.make_infested_cmd(i)
end



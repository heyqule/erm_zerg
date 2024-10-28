ErmZerg = {}

require('__erm_zerg__/global')

local ErmConfig = require('__enemyracemanager__/lib/global_config')

---
--- This is REQUIRED to register the mod as an ERM race mod.
--- There are further data processing in data-updates and data-final-fixes.
---
data.erm_registered_race = data.erm_registered_race or {}
data.erm_registered_race[MOD_NAME] = true
---
--- This set up specification for default autospawn.  This is used as reference.  The data will be balanced in
--- __enemyracemanager__/prototype/extend-default-autoplace.lua
---
data.erm_spawn_specs = data.erm_spawn_specs or {}
table.insert(data.erm_spawn_specs, {
    mod_name=MOD_NAME,
    force_name=FORCE_NAME,
    moisture=1, -- 1 = Dry and 2 = Wet
    aux=2, -- -- 1 = red desert, 2 = sand
    elevation=3, --1,2,3 (1 low elevation, 2. medium, 3 high elavation)
    temperature=3, --1,2,3 (1 cold, 2. normal, 3 hot)
})

---
--- This set of data replace vanilla biters for the menu.  It may interfere with other mods that use vanilla biter.
---
data.erm_menu_replacement = data.erm_menu_replacement or {}
data.erm_menu_replacement[MOD_NAME] = {
    race = MOD_NAME,
    level = 3,
    ['unit'] = {
        ['small-biter'] = 'zergling',
        ['small-spitter'] = 'mutalisk',
        ['medium-biter'] = 'hydralisk',
        ['medium-spitter'] = 'ultralisk',
        ['big-biter'] = 'hydralisk',
        ['big-spitter'] = 'devourer',
        ['behemoth-biter'] = 'ultralisk',
        ['behemoth-spitter'] = 'devourer',
    },
    ['turret'] = {
        ['small-worm-turret'] = 'sunken_colony',
        ['medium-worm-turret'] = 'sunken_colony',
        ['big-worm-turret'] = 'sunken_colony',
        ['behemoth-worm-turret'] = 'sunken_colony',
    },
    ['turret-scale'] = 0.8,
    ['unit-spawner'] = {
        ['biter-spawner'] = 'hive',
        ['spitter-spawner'] = 'spawning_pool',
    },
    ['unit-spawner-scale'] = 0.8
}

require 'prototypes/projectiles'
require 'prototypes/boss-projectiles'

require 'prototypes.enemy.zergling'
require 'prototypes.enemy.mutalisk'
require 'prototypes.enemy.hydralisk'
require 'prototypes.enemy.ultralisk'
require 'prototypes.enemy.devourer'
require 'prototypes.enemy.guardian'
require 'prototypes.enemy.overlord'
require 'prototypes.enemy.lurker'
require 'prototypes.enemy.drone'
require 'prototypes.enemy.defiler'
require 'prototypes.enemy.queen'
require 'prototypes.enemy.infested'
require 'prototypes.enemy.broodling'
require 'prototypes.enemy.scourge'

require 'prototypes.building.building_death'
require 'prototypes.building.hydraden'
require 'prototypes.building.spawning_pool'
require 'prototypes.building.hatchery'
require 'prototypes.building.lair'
require 'prototypes.building.hive'
require 'prototypes.building.boss_overmind'
require 'prototypes.building.spore_colony'
require 'prototypes.building.sunken_colony'
require 'prototypes.building.chamber'
require 'prototypes.building.spire'
require 'prototypes.building.greater_spire'
require 'prototypes.building.queen_nest'
require 'prototypes.building.defiler_mound'
require 'prototypes.building.ultralisk_cavern'
require 'prototypes.building.nyduspit'
require 'prototypes.building.infested_cmd'

---
--- Register unit from 1 to up to 25
---
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

---
--- Register unit with boss levels.
--- Replace its AI with boss AI
---
local boss_level = ErmConfig.BOSS_LEVELS

local boss_unit_ai = { destroy_when_commands_fail = true, allow_try_return_to_spawner = false }
local override_units_ai = {'zergling','hydralisk','mutalisk','devourer','guardian','overlord','lurker','drone','defiler','queen','infested','ultralisk','broodling','scourge'}

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

    for _, unit in pairs(override_units_ai) do
        data.raw['unit'][MOD_NAME..'--'..unit..'--'..level]['ai_settings'] = boss_unit_ai
    end
end

---
--- Register spawner/turret with max_level
---
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
    ErmZerg.make_sunken_colony(i)
    ErmZerg.make_infested_cmd(i)
end

data.erm_land_scout = data.erm_land_scout or {}
data.erm_land_scout[MOD_NAME] = 'zergling'

data.erm_aerial_scout = data.erm_aerial_scout or {}
data.erm_aerial_scout[MOD_NAME] = 'mutalisk'

require 'prototypes.planets'
require 'prototypes.update-teamcolour'
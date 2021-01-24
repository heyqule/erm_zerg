ErmZerg = {}

require('__erm_zerg__/global')

local ErmConfig = require('__enemyracemanager__/lib/global_config')

local ZergProjectileAnimation = require('__erm_zerg__/prototypes/projectile_animation')

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

require "prototypes.building.building_death"
require "prototypes.building.hydraden"
require "prototypes.building.spawning_pool"
require "prototypes.building.hatchery"
require "prototypes.building.lair"
require "prototypes.building.hive"
require "prototypes.building.spore_colony"
require "prototypes.building.sunker_colony"
require "prototypes.building.chamber"
require "prototypes.building.spire"
require "prototypes.building.greater_spire"
require "prototypes.building.queen_nest"
require "prototypes.building.defiler_mound"
require "prototypes.building.ultralisk_cavern"
require "prototypes.building.nyduspit"

data:extend({ ZergProjectileAnimation.create_lurker_spike() })
data:extend({ ZergProjectileAnimation.create_colony_spike() })
data:extend({ ZergProjectileAnimation.create_mutalisk_ball() })
data:extend({ ZergProjectileAnimation.create_mutalisk_hit_effect() })
data:extend({ ZergProjectileAnimation.create_hydralisk_projectile() })
data:extend({ ZergProjectileAnimation.create_hydralisk_hit() })
data:extend({ ZergProjectileAnimation.create_defiler_cloud() })
data:extend({ ZergProjectileAnimation.create_queen_cloud() })
data:extend({ ZergProjectileAnimation.create_slow_ticker() })

local level = ErmConfig.get_max_level(settings)

for i = 1, level do
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
end






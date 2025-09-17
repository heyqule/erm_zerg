ErmZerg = {}

require("__erm_zerg__/global")

local ErmConfig = require("__enemyracemanager__/lib/global_config")

require "prototypes.noise-functions"
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

require "prototypes/projectiles"

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
require "prototypes.building.spore_colony"
require "prototypes.building.sunken_colony"
require "prototypes.building.chamber"
require "prototypes.building.spire"
require "prototypes.building.greater_spire"
require "prototypes.building.queen_nest"
require "prototypes.building.defiler_mound"
require "prototypes.building.ultralisk_cavern"
require "prototypes.building.nyduspit"
require "prototypes.building.infested_cmd"

require "prototypes.building.boss_overmind"
require "prototypes.building.boss_nyduspit"

---
--- Register units
---
local max_level = ErmConfig.MAX_LEVELS

for i = 1, max_level do
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
data.erm_land_scout[MOD_NAME] = "zergling"

data.erm_aerial_scout = data.erm_aerial_scout or {}
data.erm_aerial_scout[MOD_NAME] = "mutalisk"


if mods["space-age"] and mods['quality'] then
    ---
    --- Register unit with boss levels.
    --- Replace its AI with boss AI
    ---
    require "prototypes/boss-projectiles"
    local max_boss_tier = ErmConfig.BOSS_MAX_TIERS

    local boss_unit_ai = ErmConfig.BOSS_AI
    local override_units_ai = {"zergling","hydralisk","mutalisk","devourer","guardian","overlord","lurker","drone","defiler","queen","infested","ultralisk","broodling","scourge"}

    local level = ErmConfig.BOSS_UNIT_TIER
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
    for _, unit in pairs(override_units_ai) do
        data.raw["unit"][MOD_NAME.."--"..unit.."--"..level]["ai_settings"] = boss_unit_ai
    end

    --- Define boss prototypes data
    local boss_data = {}

    --- FINAL_HP = base * 10 (evolution mulitplier) * quality multiplier
    --- @see prototype/extend-quality.lua for quality level details
    --- appox 20mil, 35mil, 50mil, 75mil, 100mil
    boss_data.hive_hp = {2000000, 2700000, 3250000, 4000000, 4050000}
    boss_data.nyduspit_hp = {5000, 8000, 11000, 14500, 20000}
    --- for spawner's spawning_cooldown
    boss_data.hive_spawn_timer = {
        {720,720},
        {600,600},
        {540,540},
        {480,480},
        {420,420},
    }

    boss_data.nyduspit_spawn_timer = {
        {900,900},
        {800,800},
        {700,700},
        {650,650},
        {600,600}
    }
    --- for spawner's max_count_of_owned_units
    boss_data.hive_units_count = {20, 25, 30, 35, 40}
    boss_data.nyduspit_units_count = {6, 10, 13, 16, 20}

    for i = 1, max_boss_tier do
        ErmZerg.make_boss_hive(i, boss_data)
        ErmZerg.make_boss_nyduspit(i, boss_data)
    end

    --- Boss general attack data
    --- @see script/boss_attack.lua for attack definitions and pattern.
    data.extend({
        {
            type = 'mod-data',
            name = MOD_NAME..'--boss-attack-data',
            data_type = MOD_NAME..'.boss_data',
            data = {
                --- Max assist spawner
                max_buildable_unit_spawner = {5, 6, 8, 10, 12},
                --- Phase_change, Ulitmate, Special, Assist, Heavy, Basic
                defense_attacks={1000000, 2500000, 250000, 100000, 50000, 20000},
                --- max defense attacks per heartbeat.
                max_attacks_per_heartbeat={3,4,4,5,5},
                --- Idle attack (in ticks)
                idle_attack_interval = {90 * second, 85 * second, 60 * second, 53 * second, 45 * second}
            }
        },
    })

    --- Boss reward data
    data.extend({
        {
            type = 'mod-data',
            name = MOD_NAME..'--boss-reward-data',
            data_type = MOD_NAME..'.boss_reward_data',
            data = {
                reward_data = {
                    "char_geyser",
                    "char_mineral_2",
                    "char_mineral",
                    "uranium-238",
                    "sulfuric-acid-barrel",
                    "plastic-bar",
                    "sulfur",
                    "steel-plate",
                    "solid-fuel",
                    "piercing-rounds-magazine",
                    "stone-wall",
                    "light-oil-barrel",
                    "petroleum-gas-barrel",
                    "copper-plate",
                    "iron-plate",
                    "stone-brick",
                    "crude-oil-barrel",
                    "iron-gear-wheel",
                    "iron-stick",
                    "electronic-circuit",
                    "coal",
                    "concrete",
                }
            }
        },
    })

    if DEBUG then
        --- For debug
        data.raw['mod-data'][MOD_NAME..'--boss-attack-data'].data.idle_attack_interval = {5 * second, 5 * second, 5 * second, 5 * second, 5 * second,}
    end
    
    data.extend({
        {
            type = "kill-achievement",
            name = MOD_NAME.."--death-start",
            to_kill = "enemy_erm_zerg--boss_overmind--1",
            amount = 1,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/zergling.png",
            icon_size = 64,
            allow_without_fight = false,
            order = "z["..MOD_NAME.."]--01-death-start"
        },
        {
            type = "kill-achievement",
            name = MOD_NAME.."--rally-the-char",
            to_kill = "enemy_erm_zerg--boss_overmind--3",
            amount = 1,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/overlord.png",
            icon_size = 64,
            allow_without_fight = false,
            order = "z["..MOD_NAME.."]--02-rally-the-char"
        },
        {
            type = "kill-achievement",
            name = MOD_NAME.."--planet-fall",
            to_kill = "enemy_erm_zerg--boss_overmind--5",
            amount = 1,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/ultralisk.png",
            icon_size = 64,
            allow_without_fight = false,
            order = "z["..MOD_NAME.."]--03-planet-fall"
        },
    })
end

require "prototypes.tips_and_tricks.prototypes"
require "prototypes.economy"
require "prototypes.planets"
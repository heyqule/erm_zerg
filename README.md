# ERM_Zerg
Add Zergs to factorio as biters.

This mod is created as an example race for [Enemy Race Manager](https://github.com/heyqule/enemy_race_manager)

All graphic and sound assets in this mod are properties of Blizzard Entertainment Inc

# Requirement
* Enemy Race Manager >= 0.3
* Factorio Standard Library >= 1.4.6
* Factorio Base >= 1.1

# Features
All unit has same base health point as original SC, Some units have unique health multiplier to balance bullet damage.

Tier 1 Units
* Zergling
    - Health 35 * 2.5
    - melee damage 5-50
    - Resist: 95
* Hydralisk
    - Health 80 * 2
    - range damage 10-60
    - Resist: 90
* Mutalisk
    - Health 120 * 1.5
    - range damage 10-60
    - Resist: 95

Tier 2 Units
* Overlord
    - Health 200 * 1.5
    - Drops ling / hydra / infested
    - Resist: 95
* Lurker
    - Health 125 * 1.5
    - AOE range damage 20-75
    - Resist: 90
* Infested
    - Health 60 * 2
    - AOE range damage 50-150
    - Resist: 95
* Guardian
    - Health 150 * 1.5
    - range damage 20-70
    - Resist: 90
* Devourer
    - Health 250 * 1.25
    - range damage 25-85
    - slow on hit
    - Resist: 95
* Drone
    - Health 40 * 2
    - Kill itself to spawns spore colony or nyduspit
    - Resist: 90

Tier 3 Units
* Queen
    - Health 120 * 2
    - AOE healer 100-500 / AOE range damage 25-50
    - Resist: 90
* Defiler
    - Health 80 * 2
    - AOE range damage 50-100
    - Resist: 90
* Ultralisk
    - Health 400 * 1.25
    - AOE melee damage 25-150
    - Resist: 95

Technical Note
--------------------
Unit/Building Name Convention

name = MOD_NAME..'/'..name .. '/' .. level,
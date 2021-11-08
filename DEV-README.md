Developer Read Me
--------------------
This readme should be able give you a quick start to creating you new race.

#### global.lua

defines mod constants. Please see that file for additional requirements.

#### setting-update.lua
add your race to setting's dropdowns

#### data.lua
Use this file to add unit/spawner to the game

#### control.lua
Use this file to hook up the race data and control any custom attack.

Point of interests:

* the race specific file includes
    * change / remove them
* addRaceSettings()
    * change the unit and spawner tiers
    * angry meter (Use as a future feature)
    * [__enemyracemanager__/lib/remote_api.lua](https://github.com/heyqule/enemy_race_manager/blob/main/lib/remote_api.lua)
* Event.register(defines.events.on_script_trigger_effect, function(event) end
    * handles custom attacks

####Units:
Many of the units have unique abilities, please refer to the lua files for reference

* Melee: [Zergling](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/zergling.lua)
* Melee AOE: [Ultralisk](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/ultralisk.lua)
* Range: [Hydralisk](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/hydralisk.lua)
* Flying Unit: [Mutalisk](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/mutalisk.lua)
* Max range attack: [Guardian](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/guardian.lua)
* Slow attack: [Devourer](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/devourer.lua)
* AOE healing: [Queen](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/queen.lua)
* Range AOE: 
    * [Defiler](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/defiler.lua)
    * [Lurker](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/lurker.lua)

These units' attacks are handled via on_script_trigger_effect events
* Self destruction unit: [Infested](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/infested.lua)
* Dropping new unit: [Overlord](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/overlord.lua)
* Construct new building with self destruct: [Drone](https://github.com/heyqule/erm_zerg/blob/main/prototypes/enemy/drone.lua)

######Default File to include:
```lua
require('__stdlib__/stdlib/utils/defines/time')  --Handle date/time definies
local Sprites = require('__stdlib__/stdlib/data/modules/sprites') --Handle empty sprites

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit_helper') -- Unit Helper functions, use for calculating health, damage and etc.
local ERM_UnitTint = require('__enemyracemanager__/lib/unit_tint') -- Unit tint functions, use for tinting air unit exhaust and shadows.
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper') -- some debug function
local ERM_Config = require('__enemyracemanager__/lib/global_config') -- Get proper settings for max level, max range and etc.
local ZergSound = require('__erm_zerg__/prototypes/sound') -- All sounds are handled in single lua file.  It's easier to modify.
```

####Unit/Building Name Convention
```lua
name = MOD_NAME .. '/' .. name .. '/' .. level,
localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
```
* MOD_NAME is defined in global.lua
* name is the unit name
   
#### Unit Spawners:
Please see [prototype/building/hive.lua](https://github.com/heyqule/erm_zerg/blob/main/prototypes/building/hive.lua) for details.



#### Turrets:
It feels more balance to have both splitter acid and direct attack for base defense.
* Spitter Acid attack: [prototype/building/spore_colony.lua](https://github.com/heyqule/erm_zerg/blob/main/prototypes/building/spore_colony.lua) 
* Direct Attack: [prototype/building/sunker_colony.lua](https://github.com/heyqule/erm_zerg/blob/main/prototypes/building/sunker_colony.lua)

##### HP Guideline:
Unit HP:
level 1 are under 500, median none
level 10 are 1000 - 5000, median 1500-2500
level 20 are 2500 - 10000, median 3000-5000

Spawner/Turret HP:
turrets are 4000 - 6000 
proxy spawners are usually 5000 - 8000 health
support spawner are 6000 - 12000
command center 12000+

##### Max Resistance Guideline:
Unit Resistance:
Max Physical: 95%
Elemental: 90%
Weak Elemental: 85%

Spawner/Turret Resistance:
Max Physical: 85%
Elemental: 80%
Weak Elemental: 75%

##### Damage Guideline:
level 1: 10 - 50 DPS
level 10: 30 - 100 DPS
level 20:  80 - 200 DPS

##### Movement Speed Guideline:
(level 1 to 20)
Slow Ground: (21-27) - (37-43)km/s
```lua
local base_movement_speed = 0.1
local incremental_movement_speed = 0.1
```

Fast Ground: (27-37) - (48-54) km/s
```lua
local base_movement_speed = 0.15
local incremental_movement_speed = 0.1
```

Normal Flyer: 32 - 59km/s
```lua
local base_movement_speed = 0.15
local incremental_movement_speed = 0.125
```

Fast Flyer: 43 - 75km/s
```lua
local base_movement_speed = 0.2
local incremental_movement_speed = 0.15
```

##### Attack Speed Guideline:
Fastest attack speed for all units is 0.25s / attack.
Attack range from 3s / attack to 4 attack/s depending on unit design and its level.

##### Attack Range Guideline:
Meele: 1
Dropship: 3
Short Range: 6
Medium Range: 9
Long Range: 12
Max Range: ERM_Config.get_max_attack_range()

min_attack_distance:
- (unit_range - 2) if unit_range > 4 and < 8
- (unit_range - 3) if unit_range >= 8 and < 12
- (unit_range - 4) if unit_range >= 12

##### pollution_to_join_attack Guideline:
Tier 1: 5 - 50
Tier 2: 50 - 200
Dropship / Drone: 200
Tier 3: 100 - 400

AOE units are in higher range. Tier 3 AOE unit generally take 300-400 range.

##### vision_distance Guideline:
Ground: 30
Air: 35

#Developer Read Me
--------------------
This readme should be able give you a quick start to creating you new race.

##### setting-update.lua
add your race to setting's dropdowns

##### data.lua
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

#####Units:
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

#####Unit/Building Name Convention
```lua
name = MOD_NAME .. '/' .. name .. '/' .. level,
localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
```
* MOD_NAME is defined in global.lua
* name is the unit name

#####Unit Spawners:
Please see [prototype/building/hive.lua](https://github.com/heyqule/erm_zerg/blob/main/prototypes/building/hive.lua) for details.

##### Turrets:
It feels more balance to have both splitter acid and direct attack for base defense.
* Spitter Acid attack: [prototype/building/spore_colony.lua](https://github.com/heyqule/erm_zerg/blob/main/prototypes/building/spore_colony.lua)
* Direct Attack: [prototype/building/sunker_colony.lua](https://github.com/heyqule/erm_zerg/blob/main/prototypes/building/sunker_colony.lua)
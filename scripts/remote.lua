---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 2/8/2023 9:02 PM
---
require('util')
local ErmConfig = require('__enemyracemanager__/lib/global_config')

local RemoteAPI = {}

---
--- Register new milestones
---
function RemoteAPI.milestones_preset_addons()
    local boss_level = ErmConfig.BOSS_LEVELS
    local preset = {
        ["erm_zerg"] = {
            required_mods = {"erm_zerg"},
            milestones = {
                {type="group", name="Kills"},
                {type="kill", name="erm_zerg/hive/5",  quantity=1},
                {type="kill", name="erm_zerg/hive/10",  quantity=1},
                {type="kill", name="erm_zerg/hive/15",  quantity=1},
                {type="kill", name="erm_zerg/hive/20",  quantity=1, next="x10"},
            }
        },
    }

    preset["erm_zerg_boss"] = {
        required_mods = {"erm_zerg"},
        milestones = {
            {type="group", name="ERM Boss Kills"},
            {type="kill", name="erm_zerg/overmind/"..boss_level[1],  quantity=1},
            {type="kill", name="erm_zerg/overmind/"..boss_level[2],  quantity=1},
            {type="kill", name="erm_zerg/overmind/"..boss_level[3],  quantity=1},
            {type="kill", name="erm_zerg/overmind/"..boss_level[4],  quantity=1},
            {type="kill", name="erm_zerg/overmind/"..boss_level[5],  quantity=1},
        }
    }

    return preset
end

---
--- Print global for debug purpose when you run remote.call('enemyracemanager_debug', 'print_global')"
---
function RemoteAPI.print_global()
    game.write_file('erm_zerg/erm-global.json',game.table_to_json(util.copy(global)))
end

---
--- This is REQUIRED to register ERM mods for control stage.
---
function RemoteAPI.register_new_enemy_race()
    return true
end

return RemoteAPI

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 2/5/2023 2:24 PM
---
require('__stdlib__/stdlib/utils/defines/time')
local noise = require("noise")
local String = require('__stdlib__/stdlib/utils/string')
local AutoplaceHelper = require('__enemyracemanager__/lib/helper/autoplace_helper')
local ErmConfig = require('__enemyracemanager__/lib/global_config')
local AutoplaceUtil = require('__enemyracemanager__/lib/enemy-autoplace-utils')
require('global')

local tune_autoplace = function(v, is_turret, volume)
    if String.find( v.name, MOD_NAME, 1, true) and v.autoplace then
        if is_turret then
            v.autoplace = AutoplaceUtil.enemy_worm_autoplace(0, FORCE_NAME, volume, 1)
        else
            v.autoplace = AutoplaceUtil.enemy_spawner_autoplace(0, FORCE_NAME, volume, 1)
        end
    end
end

if ErmConfig.mapgen_is_mixed() then
    local volume = nil
    local erm_races = AutoplaceHelper.get_erm_races()
    local active_races = table_size(erm_races)
    if active_races >= 2  then
        volume = {
            water_min = 0,
            water_max = 0.51,
        }

        if settings.startup['enemyracemanager-enable-bitters'].value and erm_races['erm_marspeople'] and active_races > 2 then
            volume.aux_min = 0.14
            volume.aux_max = 0.61
        elseif erm_races['erm_marspeople'] and active_races > 2 then
            volume.aux_min = 0.0
            volume.aux_max = 0.51
        end

    elseif settings.startup['enemyracemanager-enable-bitters'].value and active_races == 1 then
        volume = {
            water_min = 0,
            water_max = 0.51,
        }
    end

    if volume then
        for _, v in pairs(data.raw["unit-spawner"]) do
            tune_autoplace(v, false, volume)
        end

        for _, v in pairs(data.raw["turret"]) do
            tune_autoplace(v, true, volume)
        end
    end
end


local scourge = data.raw['unit']['erm_zerg/scourge/20']
scourge['time_to_live'] = 5 * defines.time.minute
local broodling = data.raw['unit']['erm_zerg/broodling/20']
broodling['time_to_live'] = 5 * defines.time.minute

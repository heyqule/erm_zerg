---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/23/2020 8:27 PM
---

local String = require('__stdlib__/stdlib/utils/string')
local Math = require('__stdlib__/stdlib/utils/math')
local Table = require('__stdlib__/stdlib/utils/table')

local ForceHelper = require('__enemyracemanager__/lib/helper/force_helper')
local CustomAttackHelper = require('__enemyracemanager__/lib/helper/custom_attack_helper')

local droppable_unit_name = {
    { 'zergling', 'hydralisk' },
    { 'zergling', 'zergling', 'hydralisk', 'hydralisk', 'lurker' },
    { 'zergling', 'zergling', 'hydralisk', 'hydralisk', 'lurker', 'infested', 'ultralisk' },
}
local get_overlord_droppable_unit = function()
    return CustomAttackHelper.get_unit(droppable_unit_name, MOD_NAME)
end

local drone_building_name = {
    { 'sunker_colony_shortrange' },
    { 'sunker_colony_shortrange' },
    { 'sunker_colony_shortrange', 'nyduspit' },
}
local get_drone_buildable_turrets = function()
    return CustomAttackHelper.get_unit(drone_building_name, MOD_NAME)
end

local CustomAttacks = {}

CustomAttacks.valid = CustomAttackHelper.valid

function CustomAttacks.process_overlord(event)
    CustomAttackHelper.drop_unit(event, MOD_NAME, get_overlord_droppable_unit())
end

function CustomAttacks.process_drone(event)
    CustomAttackHelper.drop_unit(event, MOD_NAME, get_drone_buildable_turrets())
    event.source_entity.die('neutral')
end

function CustomAttacks.process_infested(event)
    event.source_entity.die('neutral')
end

return CustomAttacks
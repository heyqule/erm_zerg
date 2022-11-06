---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/23/2020 8:27 PM
---

local CustomAttackHelper = require('__enemyracemanager__/lib/helper/custom_attack_helper')
local ERMConfig = require('__enemyracemanager__/lib/global_config')

local CustomAttacks = {}

CustomAttacks.valid = CustomAttackHelper.valid

function CustomAttacks.process_overlord(event)
    CustomAttackHelper.drop_unit(event, MOD_NAME, CustomAttackHelper.get_unit(MOD_NAME, 'droppable_units'))
end

function CustomAttacks.process_drone(event)
    CustomAttackHelper.drop_unit(event, MOD_NAME, CustomAttackHelper.get_unit(MOD_NAME, 'construction_buildings'))
    event.source_entity.die('neutral')
end

function CustomAttacks.process_infested(event)
    event.source_entity.die('neutral')
end

function CustomAttacks.process_boss_units(event, batch_size)
    batch_size = batch_size or 6
    CustomAttackHelper.drop_boss_units(event, MOD_NAME, ERMConfig.boss_spawn_size * batch_size)
end

function CustomAttacks.process_batch_units(event, batch_size)
    batch_size = batch_size or 4
    CustomAttackHelper.drop_batch_units(event, MOD_NAME, ERMConfig.boss_spawn_size * batch_size)
end

return CustomAttacks
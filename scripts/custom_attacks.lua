---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/23/2020 8:27 PM
---

local CustomAttackHelper = require("__enemyracemanager__/lib/helper/custom_attack_helper")
local ERMConfig = require("__enemyracemanager__/lib/global_config")

local CustomAttacks = CustomAttackHelper

function CustomAttacks.process_overlord(event)
    local race_settings = CustomAttackHelper.get_race_settings(MOD_NAME)
    CustomAttackHelper.drop_unit(event, MOD_NAME, "broodling", 3)
    CustomAttackHelper.drop_unit(event, MOD_NAME, "scourge", 2)
    if CustomAttackHelper.can_spawn(75) then
        CustomAttackHelper.drop_unit(event, MOD_NAME, CustomAttackHelper.get_unit(MOD_NAME, "droppable_units"))
    end
    if race_settings.tier == 3 and CustomAttackHelper.can_spawn(40) then
        CustomAttackHelper.drop_unit(event, MOD_NAME, "zergling", 2)
        if CustomAttackHelper.can_spawn(20) then
            CustomAttackHelper.drop_unit(event, MOD_NAME,  CustomAttackHelper.get_unit(MOD_NAME, "droppable_units"))
        end
    end
end

function CustomAttacks.process_queen(event)
    local race_settings = CustomAttackHelper.get_race_settings(MOD_NAME)
    CustomAttackHelper.drop_unit_at_target(event, MOD_NAME, "broodling", 2)
    if CustomAttackHelper.can_spawn(33) then
        CustomAttackHelper.drop_unit_at_target(event, MOD_NAME, "broodling", 1)
    end
    if race_settings.tier == 3 and CustomAttackHelper.can_spawn(10) then
        CustomAttackHelper.drop_unit_at_target(event, MOD_NAME, "zergling", 2)
    end
end

function CustomAttacks.process_scourge_spawn(event)
    CustomAttackHelper.drop_unit(event, MOD_NAME, "scourge", 1)
end

function CustomAttacks.process_drone(event)
    CustomAttackHelper.build(event, MOD_NAME, CustomAttackHelper.get_unit(MOD_NAME, "construction_buildings"))
    event.source_entity.destroy()
end


function CustomAttacks.process_boss_units(event, batch_size)
    batch_size = batch_size or 12
    CustomAttackHelper.drop_boss_units(event, MOD_NAME, ERMConfig.boss_spawn_size * batch_size)
end

function CustomAttacks.process_batch_units(event, batch_size)
    batch_size = batch_size or 8
    CustomAttackHelper.drop_batch_units(event, MOD_NAME, ERMConfig.boss_spawn_size * batch_size)
end

function CustomAttacks.process_self_destruct(event)
    if event.source_entity then
        event.source_entity.destroy()
    end
end

---
--- Handles aftermath of demolisher unit attack, process 20 units per batch.
--- Either build a base or kill themselves
---
function CustomAttacks.demolisher_units_attack()
    local i = 0
    local unit_group = {}
    for surface, units in pairs(storage.demolisher_units) do
        for key, unit_data in pairs(units) do
            local unit = unit_data.entity
            if unit.valid then
                local commandable = unit.commandable
                if (commandable.has_command == false or
                        commandable.command.type == defines.command.wander or
                        (commandable.command.type == defines.command.compound and commandable.command.commands[1].type == defines.command.wander)
                ) then
                    table.insert(unit_group, unit)
                    storage.demolisher_units[surface][key] = nil
                end
            elseif unit.valid == false then
                storage.demolisher_units[surface][key] = nil
            end
            i = i + 1
            if i == 20 then
                break
            end
        end

        local surface_group
        for _, unit in pairs(unit_group) do
            if surface_group == nil then
                surface_group = unit.surface.create_unit_group({position = unit.position, force = unit.force})
            end

            surface_group.add_member(unit)
        end

        if surface_group then
            --- either build base or die.
            if CustomAttacks.can_spawn(33) then
                remote.call("enemyracemanager", "build_base_formation", surface_group)
            else
                remote.call("enemyracemanager", "process_attack_position", {
                    group = surface_group,
                    distraction = defines.distraction.by_anything,
                    target_force = 'player',
                })
            end
        end
    end


end

return CustomAttacks
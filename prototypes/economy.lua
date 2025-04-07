---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 2/22/2025 5:43 PM
---

if not mods['space-age'] then
    return
end

local LarvaEgg = require('__erm_zerg_economy__/prototypes/create-egg')
local ZergPlayableEntities = require('__erm_zerg_economy__/prototypes/create-zerg-entities')
local ZergPlayableRecipes = require('__erm_zerg_economy__/prototypes/create-zerg-recipes')

local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")

local original_color = util.table.deepcopy(settings.startup["enemy_erm_zerg-team_color"].value)

local blended_color = ERM_UnitHelper.format_team_color(
        settings.startup["enemy_erm_zerg-team_color"].value,
        settings.startup["enemy_erm_zerg-team_blend_mode"].value
)

local egg_name = MOD_NAME..'--larva_egg'
--- Create recipe category and subgroup
LarvaEgg.init()
--- Create larva egg based on zerg color
LarvaEgg.create_item(egg_name, LARVA_EGG_TRIGGER, blended_color)
--- Create larva egg duplication recipe (Doesn't fresh spoil timer)
LarvaEgg.create_larva_egg_duplication_recipe(egg_name, {
    {type = "item", name = "carbon", amount = 10},
    {type = "item", name = "nutrients", amount = 50},
    {type = "fluid", name = "steam", amount = 200, temperature = 500},
},
original_color)
--- Create larva egg duplication recipe (fresh spoil timer)
LarvaEgg.create_larva_egg_fresh_duplication_recipe(egg_name, {
    {type = "item", name = "carbon", amount = 10},
    {type = "item", name = "nutrients", amount = 50},
    {type = "fluid", name = "steam", amount = 200, temperature = 500},
},
original_color)

--- ZERG_TEAM_COLOR is used in tinting biochamber in recipes.
--- Create larva egg to nutrients recipe
LarvaEgg.create_larva_egg_to_nutrients_recipe(egg_name, 50, original_color)

--- Create larva egg to biter egg recipe
LarvaEgg.create_larva_egg_to_biter_egg_recipe(egg_name, {
    {type = "item", name = "bioflux", amount = 10},
    {type = "fluid", name = "water", amount = 200},
}, original_color)

LarvaEgg.create_larva_egg_to_military_recipe(egg_name, original_color)
LarvaEgg.create_larva_egg_to_uranium238_recipe(egg_name)
LarvaEgg.create_larva_egg_to_promethium_recipe(egg_name)

LarvaEgg.create_tech(egg_name)

--- Create playable entities for zerg
ZergPlayableEntities.init(MOD_NAME)
--- ZergPlayableEntities.zergling(prefix, hp_multiplier = 1, damage_multiplier = 1)
ZergPlayableEntities.zergling(MOD_NAME)
ZergPlayableEntities.hydralisk(MOD_NAME)
ZergPlayableEntities.mutalisk(MOD_NAME)
ZergPlayableEntities.guardian(MOD_NAME)
--- ZergPlayableEntities.infested(prefix, trigger_action, hp_multiplier = 1, damage_multiplier = 1)
ZergPlayableEntities.infested(MOD_NAME, SELF_DESTRUCT_ATTACK)
ZergPlayableEntities.ultralisk(MOD_NAME)

ZergPlayableEntities.hatchery(MOD_NAME)

--- Create recipe and item for zerg
ZergPlayableRecipes.zergling(MOD_NAME, {
    {type = "item", name = "nutrients", amount = 50},
    {type = "item", name = egg_name, amount = 2},
    {type = "item", name = "quantum-processor", amount = 1},
    {type = "item", name = "superconductor", amount = 1},
    {type = "item", name = "supercapacitor", amount = 1},
})
ZergPlayableRecipes.hydralisk(MOD_NAME,{
    {type = "item", name = "nutrients", amount = 100},
    {type = "item", name = egg_name, amount = 4},
    {type = "item", name = "quantum-processor", amount = 1},
    {type = "item", name = "superconductor", amount = 1},
    {type = "item", name = "supercapacitor", amount = 1},
})
ZergPlayableRecipes.mutalisk(MOD_NAME,{
    {type = "item", name = "nutrients", amount = 200},
    {type = "item", name = egg_name, amount = 8},
    {type = "item", name = "quantum-processor", amount = 1},
    {type = "item", name = "superconductor", amount = 1},
    {type = "item", name = "supercapacitor", amount = 1},
})
ZergPlayableRecipes.guardian(MOD_NAME,{
    {type = "item", name = "nutrients", amount = 300},
    {type = "item", name = egg_name, amount = 16},
    {type = "item", name = "quantum-processor", amount = 1},
    {type = "item", name = "superconductor", amount = 1},
    {type = "item", name = "supercapacitor", amount = 1},
})
ZergPlayableRecipes.infested(MOD_NAME,{
    {type = "item", name = "nutrients", amount = 100},
    {type = "item", name = egg_name, amount = 4},
    {type = "item", name = "quantum-processor", amount = 1},
    {type = "item", name = "superconductor", amount = 1},
    {type = "item", name = "supercapacitor", amount = 1},
})
ZergPlayableRecipes.ultralisk(MOD_NAME,{
    {type = "item", name = "nutrients", amount = 500},
    {type = "item", name = egg_name, amount = 32},
    {type = "item", name = "quantum-processor", amount = 2},
    {type = "item", name = "superconductor", amount = 2},
    {type = "item", name = "supercapacitor", amount = 2},
})

ZergPlayableRecipes.hatchery(MOD_NAME,{
    {type = "item", name = "quantum-processor", amount = 10},
    {type = "item", name = "superconductor", amount = 10},
    {type = "item", name = "supercapacitor", amount = 10},
    {type = "item", name = "nutrients", amount = 1000},
    {type = "item", name = egg_name, amount = 50},
})

--- Create technology for zerg
ZergPlayableRecipes.technologies(MOD_NAME)


--- Assign larva egg to applicable spawners as loot
local lootable_spawners = {
    'hatchery', 'hive', 'lair'
}
--- Exceptional 1x, Epix 2x, Legendary 4x
local loot_multiplier = {
    [2] = {1,1},
    [3] = {2,4},
    [4] = {4,8},
    [5] = {6,12},
}

for _, spawner in pairs(lootable_spawners) do
    for tier, multiplier in pairs(loot_multiplier) do
        local unit_prototype = data.raw['unit-spawner'][MOD_NAME..'--'..spawner..'--'..tier]
        if unit_prototype then
            unit_prototype.loot = {
                {item = egg_name, count_min = multiplier[1], count_max = multiplier[2] }
            }
        end
    end
end

--- The following spanwers have 33% to drop loots
local lootable_spawner_with_probablity = {
    'ultralisk_cavern', 'queen_nest', 'greater_spire', 'defiler_mound', 'infested_cmd'
}

local loot_multiplier_with_probablity = {
    [2] = {1,1},
    [3] = {2,4},
    [4] = {4,8},
    [5] = {6,12},
}

for _, spawner in pairs(lootable_spawner_with_probablity) do
    for tier, multiplier in pairs(loot_multiplier_with_probablity) do
        local unit_prototype = data.raw['unit-spawner'][MOD_NAME..'--'..spawner..'--'..tier]
        if unit_prototype then
            unit_prototype.loot = {
                {item = egg_name, probability = 0.33, count_min = multiplier[1], count_max = multiplier[2] }
            }
        end
    end
end

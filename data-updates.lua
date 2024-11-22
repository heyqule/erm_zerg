---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 10/29/2024 2:29 AM
---
require("__erm_zerg__/global")

require "prototypes.update-teamcolour"
require "prototypes.update-demolisher"

-- Update RTS world
local mapgen = data.raw["map-gen-presets"]["default"]
mapgen["erm-rts-death-world"]["basic_settings"]["autoplace_controls"][AUTOCONTROL_NAME] = { frequency = "very-high", size = "very-big" }
mapgen["death-world"]["basic_settings"]["autoplace_controls"][AUTOCONTROL_NAME] = { frequency = "very-high", size = "very-big" }

if mapgen["erm-debug"] then
    mapgen["erm-debug"]["basic_settings"]["autoplace_controls"][AUTOCONTROL_NAME] = { frequency = 5, size = 5 }
end

local nauvis_autocontrols = data.raw.planet.nauvis.map_gen_settings.autoplace_controls
local nauvis_enemy_settings = settings.startup["enemyracemanager-nauvis-enemy"].value

if nauvis_enemy_settings == MOD_NAME then
    for key, autoplace in pairs(nauvis_autocontrols) do
        if string.find(key,"enemy_base", nil, true) or string.find(key,"enemy-base", nil, true) then
            print('Disabling autoplace on Nauvis:' .. key)
            nauvis_autocontrols[key] = nil
        end
    end

    nauvis_autocontrols[AUTOCONTROL_NAME] = {}
    print('ERM_ZERG: Nauvis AutoControl:')
    print(serpent.block(data.raw.planet.nauvis.map_gen_settings.autoplace_controls))
elseif nauvis_enemy_settings == NAUVIS_MIXED then
    nauvis_autocontrols[AUTOCONTROL_NAME] = {}

    print('ERM_ZERG: Nauvis AutoControl:')
    print(serpent.block(data.raw.planet.nauvis.map_gen_settings.autoplace_controls))
end


if feature_flags.space_travel and settings.startup["enemy_erm_zerg-on_vulcanus"].value then
    local vulcanus = data.raw.planet.vulcanus
    vulcanus.map_gen_settings.autoplace_controls[AUTOCONTROL_NAME] = {}
    --- Replace territory bosses with zerg variance.
    vulcanus.map_gen_settings.territory_settings.units = {
        MOD_NAME .. "-small-demolisher",
        MOD_NAME .. "-medium-demolisher",
        MOD_NAME .. "-big-demolisher",
    }
end
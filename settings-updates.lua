local ERM_ZERG = require "global"

table.insert(data.raw["string-setting"]["enemyracemanager-nauvis-enemy"].allowed_values, ERM_ZERG.MOD_NAME)

table.insert(data.raw["string-setting"]["enemyracemanager-2way-group-enemy-positive"].allowed_values, ERM_ZERG.MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-2way-group-enemy-negative"].allowed_values, ERM_ZERG.MOD_NAME)

table.insert(data.raw["string-setting"]["enemyracemanager-4way-northeast"].allowed_values, ERM_ZERG.MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-northwest"].allowed_values, ERM_ZERG.MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-southwest"].allowed_values, ERM_ZERG.MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-southeast"].allowed_values, ERM_ZERG.MOD_NAME)

if data.raw["string-setting"]["enemyracemanager-2way-group-enemy-positive"].default_value ~= ERM_ZERG.MOD_NAME then
    data.raw["string-setting"]["enemyracemanager-2way-group-enemy-positive"].default_value = ERM_ZERG.MOD_NAME
end

if data.raw["string-setting"]["enemyracemanager-4way-southwest"].default_value ~= ERM_ZERG.MOD_NAME then
    data.raw["string-setting"]["enemyracemanager-4way-southwest"].default_value = ERM_ZERG.MOD_NAME
end
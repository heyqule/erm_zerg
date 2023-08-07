require 'global'

table.insert(data.raw["string-setting"]["enemyracemanager-2way-group-enemy-positive"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-2way-group-enemy-negative"].allowed_values, MOD_NAME)

table.insert(data.raw["string-setting"]["enemyracemanager-4way-top-left"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-top-right"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-bottom-right"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-bottom-left"].allowed_values, MOD_NAME)


if mods['Krastorio2'] then
    data:extend {
        {
            type = "bool-setting",
            name = "erm_zerg-k2-creep",
            description = "erm_zerg-k2-creep",
            setting_type = "startup",
            default_value = true,
            order = "erm_zerg-120",
        },
    }
end

if mods['erm_zerg_hd'] then
    data:extend {
        {
            type = "color-setting",
            name = "erm_zerg-team-color",
            description = "erm_zerg-team-color",
            setting_type = "startup",
            default_value = ZERG_TEAM_COLOR,
            order = "erm_zerg-110",
        },
        {
            type = "int-setting",
            name = "erm_zerg-team-blend-mode",
            description = "erm_zerg-team-blend-mode",
            setting_type = "startup",
            default_value = 3,
            order = "erm_zerg-111",
            allowed_values = { 1,2,3,4,5,6 },
        },
    }
end
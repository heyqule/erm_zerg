require 'global'

table.insert(data.raw['string-setting']['enemyracemanager-2way-group-enemy-positive'].allowed_values, MOD_NAME)
table.insert(data.raw['string-setting']['enemyracemanager-2way-group-enemy-negative'].allowed_values, MOD_NAME)

table.insert(data.raw['string-setting']['enemyracemanager-4way-top-left'].allowed_values, MOD_NAME)
table.insert(data.raw['string-setting']['enemyracemanager-4way-top-right'].allowed_values, MOD_NAME)
table.insert(data.raw['string-setting']['enemyracemanager-4way-bottom-right'].allowed_values, MOD_NAME)
table.insert(data.raw['string-setting']['enemyracemanager-4way-bottom-left'].allowed_values, MOD_NAME)

data:extend {
    {
        type = 'bool-setting',
        name = 'erm_zerg-team_color_enable',
        description = 'erm_zerg-team_color_enable',
        setting_type = 'startup',
        default_value = true,
        order = 'erm_zerg-110',
    },
    {
        type = 'color-setting',
        name = 'erm_zerg-team_color',
        description = 'erm_zerg-team_color',
        setting_type = 'startup',
        default_value = ZERG_TEAM_COLOR,
        order = 'erm_zerg-111',
    },
    {
        type = 'int-setting',
        name = 'erm_zerg-team_blend_mode',
        description = 'erm_zerg-team_blend_mode',
        setting_type = 'startup',
        default_value = 3,
        order = 'erm_zerg-112',
        allowed_values = { 1,2,3,4,5,6 },
    },
    {
        type = 'bool-setting',
        name = 'erm_zerg-team_color_preserve_gloss',
        description = 'erm_zerg-team_color_preserve_gloss',
        setting_type = 'startup',
        default_value = false,
        order = 'erm_zerg-113',
    },
    {
        type = 'bool-setting',
        name = 'erm_zerg-enable_floor_decals',
        description = 'erm_zerg-enable_floor_decals',
        setting_type = 'startup',
        default_value = true,
        order = 'erm_zerg-115',
    },
}

local descript = "mod-setting-description.zerg-"

data:extend{
    {
        type = "bool-setting",
        name = "zerg-enemy-corpses",
        setting_type = "startup",
        default_value = true,
        order = "zerg-ca[enemy-corpses]"
    },
    {
        type = "int-setting",
        name = "zerg-enemy-corpse-time",
        setting_type = "startup",
        default_value = 15,
        minimum_value = 1,
        maximum_value = 30,
        order = "zerg-cb[enemy-corpse-time]"
    }
}

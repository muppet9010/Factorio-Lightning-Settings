data:extend(
    {
        {
            name = "lightning_settings-disable_flash",
            type = "bool-setting",
            default_value = false,
            setting_type = "startup",
            order = "1000"
        },
        {
            name = "lightning_settings-disable_impact_light",
            type = "bool-setting",
            default_value = false,
            setting_type = "startup",
            order = "1001"
        },
        {
            name = "lightning_settings-lightning_frequency_percentage",
            type = "int-setting",
            default_value = 100,
            minimum_value = 0,
            maximum_value = 1000,
            setting_type = "startup",
            order = "2000"
        },
        {
            name = "lightning_settings-lightning_damage_percentage",
            type = "int-setting",
            default_value = 100,
            minimum_value = 0,
            maximum_value = 1000,
            setting_type = "startup",
            order = "2001"
        },
        {
            name = "lightning_settings-lightning_energy_percentage",
            type = "int-setting",
            default_value = 100,
            minimum_value = 0,
            maximum_value = 1000,
            setting_type = "startup",
            order = "2002"
        }
    }
)
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
            name = "lightning_settings-disable_lightning_bolt_graphic",
            type = "bool-setting",
            default_value = false,
            setting_type = "startup",
            order = "1002"
        },
        {
            name = "lightning_settings-disable_lightning_ground_impact_graphic",
            type = "bool-setting",
            default_value = false,
            setting_type = "startup",
            order = "1003"
        },
        {
            name = "lightning_settings-disable_lightning_rod_charge_graphic",
            type = "bool-setting",
            default_value = false,
            setting_type = "startup",
            order = "1004"
        },
        {
            name = "lightning_settings-lightning_bolt_sound",
            type = "string-setting",
            default_value = "all",
            allowed_values = { "all", "unprotected", "none" },
            setting_type = "startup",
            order = "1005"
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

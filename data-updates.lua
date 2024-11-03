local Utility = require("utility")

---@enum LightningBoltSoundSettingType
local LightningBoltSoundSettingType = { all = "all", unprotected = "unprotected", none = "none" }

local disableFlash = settings.startup["lightning_settings-disable_flash"].value --[[@as boolean]] ---@type boolean
local disableImpactLight = settings.startup["lightning_settings-disable_impact_light"].value --[[@as boolean]] ---@type boolean
local disableLightningBoltGraphic = settings.startup["lightning_settings-disable_lightning_bolt_graphic"].value --[[@as boolean]] ---@type boolean
local disableLightningBoltGroundImpactGraphic = settings.startup["lightning_settings-disable_lightning_ground_impact_graphic"].value --[[@as boolean]] ---@type boolean
local disableLightningBoltRodChargeGraphic = settings.startup["lightning_settings-disable_lightning_rod_charge_graphic"].value --[[@as boolean]] ---@type boolean
local lightningBoltSoundSetting = settings.startup["lightning_settings-lightning_bolt_sound"].value --[[@as LightningBoltSoundSettingType]] ---@type LightningBoltSoundSettingType
local lightningFrequencyPercentage = settings.startup["lightning_settings-lightning_frequency_percentage"].value --[[@as integer]] ---@type integer
local lightningDamagePercentage = settings.startup["lightning_settings-lightning_damage_percentage"].value --[[@as integer]] ---@type integer
local lightningEnergyPercentage = settings.startup["lightning_settings-lightning_energy_percentage"].value --[[@as integer]] ---@type integer

local lightningPrototype ---@type data.LightningPrototype
if data.raw["lightning"] ~= nil then
    lightningPrototype = data.raw["lightning"]["lightning"]
end

local planetPrototype ---@type data.PlanetPrototype
if data.raw["planet"] ~= nil then
    planetPrototype = data.raw["planet"]["fulgora"]
end

if lightningPrototype == nil or planetPrototype == nil then return end

if disableFlash then
    lightningPrototype.created_effect = nil
end

if disableImpactLight then
    if lightningPrototype.graphics_set ~= nil then
        lightningPrototype.graphics_set.light = nil
    end
end

if disableLightningBoltGraphic then
    if lightningPrototype.graphics_set ~= nil then
        lightningPrototype.graphics_set.shader_configuration = nil
        lightningPrototype.graphics_set.cloud_background = nil
    end
end

if disableLightningBoltGroundImpactGraphic then
    lightningPrototype.strike_effect = nil
    if lightningPrototype.graphics_set ~= nil then
        lightningPrototype.graphics_set.explosion = nil
        lightningPrototype.graphics_set.ground_streamers = nil
    end
end

if disableLightningBoltRodChargeGraphic then
    if lightningPrototype.graphics_set ~= nil then
        lightningPrototype.graphics_set.attractor_hit_animation = nil
        lightningPrototype.graphics_set.ground_streamers = nil
    end
end

if lightningBoltSoundSetting ~= LightningBoltSoundSettingType.all then
    local lightningSound = lightningPrototype.sound
    lightningPrototype.sound = nil

    if lightningBoltSoundSetting == LightningBoltSoundSettingType.unprotected and lightningSound ~= nil then
        -- Prepare the strike_effect property for our addition if needed.
        if lightningPrototype.strike_effect == nil then
            -- nothing currently so make an array for us to add too.
            lightningPrototype.strike_effect = {}
        elseif #lightningPrototype.strike_effect == 0 then
            -- not an array of objects, so move the current object into an array so we can add to it later.
            local currentStrikeEffect = lightningPrototype.strike_effect
            lightningPrototype.strike_effect = { currentStrikeEffect }
        end

        -- Add our sound to the strike_effect array.
        lightningPrototype.strike_effect[#lightningPrototype.strike_effect + 1] = {
            type = "direct",
            action_delivery =
            {
                type = "instant",
                target_effects =
                {
                    {
                        type = "play-sound",
                        sound = lightningSound,
                        volume_modifier = lightningPrototype.attracted_volume_modifier,
                        play_on_target_position = true
                    }
                }
            }
        }
    end
end

if lightningFrequencyPercentage == 0 then
    planetPrototype.lightning_properties = nil
elseif lightningFrequencyPercentage ~= 100 then
    if planetPrototype.lightning_properties ~= nil then
        planetPrototype.lightning_properties.lightnings_per_chunk_per_tick = planetPrototype.lightning_properties.lightnings_per_chunk_per_tick * (lightningFrequencyPercentage / 100)
    end
end

if lightningDamagePercentage == 0 then
    lightningPrototype.damage = nil
elseif lightningDamagePercentage ~= 100 then
    lightningPrototype.damage = lightningPrototype.damage * (lightningDamagePercentage / 100)
end

if lightningEnergyPercentage == 0 then
    lightningPrototype.energy = nil
elseif lightningEnergyPercentage ~= 100 then
    local quantity, unit = Utility.GetValueAndUnitFromString(lightningPrototype.energy)
    quantity = quantity * (lightningEnergyPercentage / 100) ---@type double
    lightningPrototype.energy = quantity .. unit
end

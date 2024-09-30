local Utility = require("utility")

local disableFlash = settings.startup["lightning_settings-disable_flash"].value --[[@as boolean]] ---@type boolean
local disableImpactLight = settings.startup["lightning_settings-disable_impact_light"].value --[[@as boolean]] ---@type boolean
local lightningFrequencyPercentage = settings.startup["lightning_settings-lightning_frequency_percentage"].value --[[@as integer]] ---@type integer
local lightningDamagePercentage = settings.startup["lightning_settings-lightning_damage_percentage"].value --[[@as integer]] ---@type integer
local lightningEnergyPercentage = settings.startup["lightning_settings-lightning_energy_percentage"].value --[[@as integer]] ---@type integer

local lightningPrototype = data.raw["lightning"]["lightning"]
local planetPrototype = data.raw["planet"]["fulgora"]
if lightningPrototype == nil or planetPrototype == nil then return end

if disableFlash then
    lightningPrototype.created_effect = nil
end

if disableImpactLight then
    if lightningPrototype.graphics_set ~= nil then
        lightningPrototype.graphics_set.light = nil
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

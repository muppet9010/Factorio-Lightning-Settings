--[[
    Utility Functions
]]
local Utility = {}
local string_match = string.match

--[[    STOLEN FROM MUPPET UTILS    --]]
--- Separates out the number and unit from when they combined in a single string, i.e. 5Kwh
---@param text string
---@return double number
---@return string unit
Utility.GetValueAndUnitFromString = function(text)
    return string_match(text, "%d+%.?%d*"), string_match(text, "%a+")
end

return Utility

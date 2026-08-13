---Rounds a number to a given amount of decimal places.
---@param n number
---@param decimalPlaces? integer
---@return number
function math.round(n, decimalPlaces)
    if not decimalPlaces then decimalPlaces = 0 end
    local multiplier = 10 ^ decimalPlaces
    return math.floor(multiplier * n + 0.5) / multiplier
end

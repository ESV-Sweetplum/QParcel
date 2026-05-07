---Alias of [tonumber](lua://tonumber) for type coercion. Converts boolean values into their respective binary digits.
---@param x string | number | boolean
---@param defaultValue? number
---@return number
function math.toNumber(x, defaultValue)
    if not x then return defaultValue or 0 end
    if x == true then return 1 end
    local result = tonumber(x)
    if (not result or type(result) ~= 'number') then return 0 end
    return result
end

tn = math.toNumber

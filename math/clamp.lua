---Restricts a number to be within a chosen bound.
---@generic T: number | integer
---@param number T
---@param lowerBound T
---@param upperBound T
---@return T
function math.clamp(number, lowerBound, upperBound)
    if number < lowerBound then return lowerBound end
    if number > upperBound then return upperBound end
    return number
end

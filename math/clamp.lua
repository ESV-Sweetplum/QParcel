---Restricts a number to be within a chosen bound.
---@generic N: number | integer
---@param number N
---@param lowerBound N
---@param upperBound N
---@return N
function math.clamp(number, lowerBound, upperBound)
    if number < lowerBound then return lowerBound end
    if number > upperBound then return upperBound end
    return number
end

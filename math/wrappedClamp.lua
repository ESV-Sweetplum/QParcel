---Restricts a number to be within a closed ring.
---@generic N: number | integer
---@param number N
---@param lowerBound N
---@param upperBound N
---@return N
function math.wrappedClamp(number, lowerBound, upperBound)
    if number < lowerBound then return upperBound end
    if number > upperBound then return lowerBound end
    return number
end

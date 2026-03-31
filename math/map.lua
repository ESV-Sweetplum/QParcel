require("math.lerp")
---Maps a value `x1` to the return value `x2` using a linear transformation, where a1 -> b1 is the original vector and a2 -> b2 is the resultant vector.
---@param a1 number
---@param b1 number
---@param x1 number
---@param a2 number
---@param b2 number
function math.map(a1, b1, x1, a2, b2)
    return math.lerp(a2, b2, math.iLerp(a1, b1, x1))
end

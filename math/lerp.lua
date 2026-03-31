---Returns a number that is `(t * 100)%` of the way from travelling between `a` and `b`.
---@param a number
---@param b number
---@param t number
---@return number
function math.lerp(a, b, t)
    return a + (b - a) * t
end

---On a number line, returns the percentage of which `x` is, progressing from `a` to `b`.
---@param a number
---@param b number
---@param x number
---@return number
function math.inverseLerp(a, b, x)
    return (x - a) / (b - a)
end

math.iLerp = math.inverseLerp

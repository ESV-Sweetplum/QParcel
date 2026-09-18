---Returns n choose r, or nCr.
---@param n integer
---@param r integer
---@return integer
function math.binom(n, r)
    local result = math.factorial(n) / (math.factorial(r) * math.factorial(n - r))
    ---@cast result integer
    return result
end

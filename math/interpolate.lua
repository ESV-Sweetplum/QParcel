require("math.lerp")
--[[Creates a samplable function which interpolates the point list with a basic algorithm described by the following spec:

If `#pointList == 2`, creates a linear interpolation.

Otherwise, for every ordered group of 3 points within `pointList` (123, 234, 345, etc.):

If `p1 == p2`, creates a constant interpolation.

If `p3-p2` and `p2-p1` are the same sign, creates an exponential interpolation that uses p1, p2, and p3, but only renders within p1-p2.

Otherwise, creates a cubic hermite spline within p1-p2, where both `p2' = 0`.

Each group's `p1` inherits its derivative from the last group's `p2`, except for the first group, which uses a `p1'` such that the derivative is maximized and is monotonic.

This process repeats until the last ordered group has a generated function.
]]
---@param pointList number[]
function math.interpolateBasic(pointList)
    if (#pointList == 2) then
        return function(x)
            return math.lerp(pointList[1], pointList[2], x)
        end
    end

    local functionTable = {}
    local pastDerivative = nil

    for i = 1, #pointList - 2 do
        local p1 = pointList[i]
        local p2 = pointList[i + 1]
        local p3 = pointList[i + 2]

        if (math.abs(p2 - p1) < 1e-5) then
            table.insert(functionTable, function(_) return p1 end)
            pastDerivative = 0
            goto nextGroup
        elseif ((p2 - p1) * (p3 - p2) <= 0) then
            if (not pastDerivative) then -- Ensure past derivative is nonnegative and is as large as possible by setting the discriminant to 0.
                pastDerivative = 3 * (p2 - p1)
            end
            local p1Prime = pastDerivative
            local p2Prime = 0
            local a = p1Prime + p2Prime - 2 * (p2 - p1)
            local b = 3 * (p2 - p1) - 2 * p1Prime - p2Prime
            local c = p1Prime
            local d = p1
            table.insert(functionTable, function(x)
                return a * x * x * x + b * x * x + c * x + d
            end)

            pastDerivative = 0
        else
            local b = (p3 - p2) / (p2 - p1)
            local a = (p2 - p1) / (b - 1)
            local c = p1 - a

            table.insert(functionTable, function(x)
                return a * b ^ x + c
            end)

            pastDerivative = a * b * math.log(b)
        end

        ::nextGroup::
    end

    return function(x)
        if (x < 0 or x > #functionTable) then return nil end
        local fracX = math.frac(x)
        local usedFn = functionTable[math.floor(x) + 1]

        return usedFn(fracX)
    end
end

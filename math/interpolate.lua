require('math.lerp')
require('math.round')
--[[Creates a samplable function which interpolates the point list with a basic algorithm described by the following spec:

If `#pointList == 2`, creates a linear interpolation.

Otherwise, for every ordered group of 3 points within `pointList` (123, 234, 345, etc.):

If `p1 == p2`, creates a constant interpolation.

Otherwise, if p1, p2, and p3 are not monotone, creates a cubic hermite spline within p1-p2, where `p2' = 0`.

Otherwise, creates a cubic semi-hermite spline within `p1-p2` using p1, p2, and p3, where `p1' = 0` and `p2'` is free.

Each group's `p1` inherits its derivative from the last group's `p2`, except for the first group, which uses a `p1'` such that the derivative is maximized and is monotonic.

This process repeats until the last ordered group has a generated function. The gap between the final two points is constructed with a cubic interpolation given the past derivative.

Interally, all functions have a domain of [0,1], and the inputted x-value is fractionalized before entering the function table.
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
        elseif ((p3 - p2) * (p2 - p1) <= 0) then -- p2Prime should be 0.
            if (not pastDerivative) then         -- Ensure past derivative is nonnegative and is as large as possible by setting the discriminant to 0.
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
        else                       -- Cubic interpolation of 3 points with missing degree of freedom accounted for via the derivative at p1.
            if (not pastDerivative) then
                pastDerivative = 0 -- Initialize ramping cubic, ensuring monotonicity within p1-p2.
            end
            local p1Prime = pastDerivative
            local a = (p3 - 4 * p2 + 3 * p1 + 2 * p1Prime) / 4
            local b = -p3 / 4 + 2 * p2 - 7 / 4 * p1 - 3 / 2 * p1Prime
            local c = p1Prime
            local d = p1

            table.insert(functionTable, function(x)
                return a * x * x * x + b * x * x + c * x + d
            end)

            pastDerivative = 3 * a + 2 * b + c
        end

        ::nextGroup::
    end

    local pQuarterfinal = pointList[#pointList - 2]
    local pSemifinal = pointList[#pointList - 1]
    local pFinal = pointList[#pointList]

    local b = (pFinal + pQuarterfinal) / 2 - pSemifinal
    local a = (pFinal - pQuarterfinal) / 2 - pastDerivative
    local c = pastDerivative
    local d = pSemifinal

    table.insert(functionTable, function(x)
        return a * x * x * x + b * x * x + c * x + d
    end)

    return function(x)
        if (x < 0 or x > #functionTable) then return 1e10 end
        local fracX = math.frac(x)
        local tolerance = 1e-5
        if (fracX < tolerance or fracX > 1 - tolerance) then
            return pointList[math.round(x) + 1]
        end

        local usedFn = functionTable[math.min(math.floor(x) + 1, #functionTable)]

        return usedFn(fracX)
    end
end

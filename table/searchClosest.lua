---In an array of numbers, searches for the closest number to `item`.
---@generic N: number | integer
---@param tbl N[] The array of numbers to search in.
---@param item N The number to search for.
---@param searchMode? 0|1|2 `0/nil`: Search before and after. `1`: Search only before. `2`: Search only after.
---@return N num, integer index The number that is the closest to the given item, and the index of that number in the given table.
function table.searchClosest(tbl, item, searchMode)
    local leftIdx = 1
    local rightIdx = #tbl

    while rightIdx - leftIdx > 1 do
        local middleIdx = math.floor((leftIdx + rightIdx) * 0.5)
        if item >= tbl[middleIdx] then
            leftIdx = middleIdx
        else
            rightIdx = middleIdx
        end
    end

    local leftDifference = item - tbl[leftIdx]
    local rightDifference = tbl[rightIdx] - item

    if leftDifference < 0 then return tbl[leftIdx], leftIdx end
    if rightDifference < 0 then return tbl[rightIdx], rightIdx end

    if (leftDifference < rightDifference or searchMode == 1) and searchMode ~= 2 then
        return tbl[leftIdx], leftIdx
    else
        return tbl[rightIdx], rightIdx
    end
end

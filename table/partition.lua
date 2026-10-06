---Returns two new tables, the first is a table with all the elements that returned true when passed into the filter function. Naturally, the second return value is a table with all the elements that didn't return true when passed into the filter function.
---@generic T
---@param tbl T[]
---@param fn fun(element: T): boolean
---@return T[], T[]
function table.partition(tbl, fn)
    local tblTrue = {}
    local tblFalse = {}
    for _, v in ipairs(tbl) do
        if fn(v) then
            table.insert(tblTrue, v)
        else
            table.insert(tblFalse, v)
        end
    end

    return tblTrue, tblFalse
end

require('table.partition')

---Returns a new table, filtered via a given function. For each element in the table, it is passed into the function; if the function returns true, the value is kept, and if the function returns false, the value will not be kept in the new array.
---@generic T
---@param tbl T[]
---@param fn fun(element: T): boolean
---@return T[]
function table.filter(tbl, fn)
    local newTbl = table.partition(tbl, fn)

    return newTbl
end

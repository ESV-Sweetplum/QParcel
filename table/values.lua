require('packages.table.construct')
---Returns a table of values from a table.
---@generic T
---@param tbl { [string]: T } The table to search in.
---@return T[] values A list of values.
function table.values(tbl)
    local resultsTbl = {}

    for _, v in pairs(tbl) do
        table.insert(resultsTbl, v)
    end

    return resultsTbl
end

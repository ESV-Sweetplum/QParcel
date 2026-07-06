---Returns true if one or more item(s) in the table individually return true when passed into the given `fn`.
---@generic T: string | number | boolean
---@param tbl T[]
---@param fn fun(element: T): boolean
---@return boolean
function table.some(tbl, fn)
    for _, v in ipairs(tbl) do
        if (fn(v)) then return true end
    end

    return false
end

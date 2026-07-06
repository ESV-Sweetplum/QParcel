---Returns true only if all items in the table individually return true when passed into the given `fn`.
---@generic T: string | number | boolean
---@param tbl T[]
---@param fn fun(element: T): boolean
---@return boolean
function table.every(tbl, fn)
    for _, v in ipairs(tbl) do
        if (not fn(v)) then return false end
    end

    return true
end

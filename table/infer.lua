---Converts a string to a primitive given the type to infer from.
---@generic T: "nil" | "number" | "string" | "boolean" | "table" | "function" | "thread" | "userdata"
---@param v string? The input value.
---@param t T The type to infer from.
---@return T?
function table.infer(v, t)
    if (v == nil or t == 'table' or t == 'userdata') then
        return nil
    end
    if t == 'number' then
        return tn(v)
    end
    if t == 'boolean' then
        return truthy(v)
    end
    if t == 'string' then
        return v
    end
    return v
end

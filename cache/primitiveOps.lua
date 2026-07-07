---Gets a value from the cache.
---@generic T
---@param id string The identifier.
---@param fallback? T If the item doesn't exist, returns this instead.
---@return T
---@nodiscard
function cache.get(id, fallback) return state.GetValue(id, fallback) end

---Sets an item in the cache to the given value.
---@param id string The identifier.
---@param value any The data.
function cache.set(id, value)
    state.SetValue(id, value)
    if not _QParcelConfig.saveCacheTree then return end

    local terms = id:split('/')
    local maxDepth = #terms
    local tree = cache.tree

    for depth = 1, maxDepth do
        if not tree[terms[depth]] then tree[terms[depth]] = {} end
        if depth == maxDepth then
            tree[terms[depth]] = value
        else
            tree = tree[terms[depth]]
        end
    end
end

---Returns the string that has the 'closest distance' to the target string. If two strings have an identical matching factor, returns the string that is alphabetically first.
---@param str string
---@param list Array<string>
---@return string, integer
function string.searchClosest(str, list)
    local similarity = 0
    local storedIdx = -1
    local storedResult = ''
    for idx, target in pairs(list) do
        local m = str:compare(target)
        if m > similarity then
            similarity = m
            storedResult = target
            storedIdx = idx
        end
    end
    return storedResult, storedIdx
end

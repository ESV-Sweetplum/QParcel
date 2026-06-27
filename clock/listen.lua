require('packages.cache')

---Returns true every `interval` ms.
---@param id string The unique identifier of the clock.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.listen(id, interval)
    local currentTime = state.UnixTime -- Avoid calling state global multiple times, which causes a heavy load on performance
    local cacheId = 'clock/' .. id
    local prevTime = cache.get(cacheId, -1)
    if prevTime == -1 then
        cache.set(cacheId, currentTime)
        return false
    end
    if currentTime - prevTime > interval then
        cache.set(cacheId, currentTime)
        return true
    end

    return false
end

---A temporary clock that can be called multiple times. Should only be used for testing/debugging.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.temp(interval)
    tempClockCount = tempClockCount + 1
    return clock.listen('temporary' .. tempClockCount, interval)
end

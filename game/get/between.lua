---Returns a list of [bookmarks](lua://Bookmark) between two times, inclusive.
---@param firstOffset number The lower bound of the search area.
---@param lastOffset number The upper bound of the search area.
---@return Bookmark[] bms All of the [bookmarks](lua://Bookmark) within the area.
function game.get.bookmarksBetweenOffsets(firstOffset, lastOffset)
    local bookmarksBetweenOffsets = {} ---@type Bookmark[]
    for _, bm in ipairs(map.Bookmarks) do
        local bmIsInRange = bm.StartTime >= firstOffset and bm.StartTime < lastOffset
        if bmIsInRange then table.insert(bookmarksBetweenOffsets, bm) end
    end
    return sort(bookmarksBetweenOffsets, sortAscendingStartTime)
end

---Returns a list of [timing points](lua://TimingPoint) between two times, inclusive.
---@param firstOffset number The lower bound of the search area.
---@param lastOffset number The upper bound of the search area.
---@return TimingPoint[] tps All of the [timing points](lua://TimingPoint) within the area.
function game.get.linesBetweenOffsets(firstOffset, lastOffset)
    local linesBetweenoffsets = {} ---@type TimingPoint[]
    for _, line in ipairs(map.TimingPoints) do
        local lineIsInRange = line.StartTime >= firstOffset and line.StartTime < lastOffset
        if lineIsInRange then table.insert(linesBetweenoffsets, line) end
    end
    return sort(linesBetweenoffsets, sortAscendingStartTime)
end

---Returns a list of [hit objects](lua://HitObject) between two times, inclusive.
---@param firstOffset number The lower bound of the search area.
---@param lastOffset number The upper bound of the search area.
---@return HitObject[] objs All of the [hit objects](lua://HitObject) within the area.
function game.get.notesBetweenOffsets(firstOffset, lastOffset)
    local notesBetweenOffsets = {} ---@type HitObject[]
    for _, note in ipairs(map.HitObjects) do
        local noteIsInRange = note.StartTime >= firstOffset and note.StartTime <= lastOffset
        if noteIsInRange then table.insert(notesBetweenOffsets, note) end
    end
    return sort(notesBetweenOffsets, sortAscendingStartTime)
end

---Returns a list of [scroll speed factors](lua://ScrollSpeedFactor) between two times, inclusive.
---@param firstOffset number The lower bound of the search area.
---@param lastOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@param dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollSpeedFactor[] ssfs All of the [scroll speed factors](lua://ScrollSpeedFactor) within the area.
function game.get.ssfsBetweenOffsets(firstOffset, lastOffset, includeEnd, dontSort)
    local ssfsBetweenOffsets = {} ---@type ScrollSpeedFactor[]
    local ssfs = map.ScrollSpeedFactors
    if ssfs == nil then
        ssfs = {}
    else
        for _, ssf in ipairs(map.ScrollSpeedFactors) do
            local ssfIsInRange = ssf.StartTime >= firstOffset and ssf.StartTime < lastOffset
            if includeEnd and ssf.StartTime == lastOffset then ssfIsInRange = true end
            if ssfIsInRange then table.insert(ssfsBetweenOffsets, ssf) end
        end
    end
    if dontSort then return ssfsBetweenOffsets end
    return sort(ssfsBetweenOffsets, sortAscendingStartTime)
end

---Returns a list of [scroll velocities](lua://ScrollVelocity) between two times, inclusive.
---@param firstOffset number The lower bound of the search area.
---@param lastOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@param dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollVelocity[] svs All of the [scroll velocities](lua://ScrollVelocity) within the area.
function game.get.svsBetweenOffsets(firstOffset, lastOffset, includeEnd, dontSort)
    local svsBetweenOffsets = {} ---@type ScrollVelocity[]
    for _, sv in ipairs(map.ScrollVelocities) do
        local svIsInRange = sv.StartTime >= firstOffset and sv.StartTime < lastOffset
        if includeEnd and sv.StartTime == lastOffset then svIsInRange = true end
        if svIsInRange then table.insert(svsBetweenOffsets, sv) end
    end
    if dontSort then return svsBetweenOffsets end
    return sort(svsBetweenOffsets, sortAscendingStartTime)
end

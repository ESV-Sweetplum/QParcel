---@param e QueueElement
function queue.add(e)
    local function insertIfExists(tbl, key)
        local item = e[key]
        if (not item) then return end
        table.insert(tbl, item)
        queue.edited[key] = true
    end

    local function insertManyIfExists(tbl, key)
        local items = e[key]
        if (not items) then return end
        if (not truthy(#items)) then items = { items } end
        for i = 1, #items do
            local item = items[i]
            table.insert(tbl, item)
        end
        queue.edited[key] = true
    end

    insertManyIfExists(queue.cur.bmsToAdd, "AddBookmarks")
    insertManyIfExists(queue.cur.bmsToRemove, "RemoveBookmarks")

    insertManyIfExists(queue.cur.hosToAdd, "AddHitObjects")
    insertManyIfExists(queue.cur.hosToRemove, "RemoveHitObjects")

    insertIfExists(queue.cur.layersToAdd, "CreateLayer")
    insertIfExists(queue.cur.layersToRemove, "RemoveLayer")

    insertManyIfExists(queue.cur.svsToAdd, "AddScrollVelocities")
    insertManyIfExists(queue.cur.svsToRemove, "RemoveScrollVelocities")

    insertManyIfExists(queue.cur.ssfsToAdd, "AddScrollSpeedFactors")
    insertManyIfExists(queue.cur.ssfsToRemove, "RemoveScrollSpeedFactors")

    insertIfExists(queue.cur.tgsToAdd, "CreateTimingGroup")
    insertIfExists(queue.cur.tgsToRemove, "RemoveTimingGroup")

    insertManyIfExists(queue.cur.tpsToAdd, "AddTimingPoints")
    insertManyIfExists(queue.cur.tpsToRemove, "RemoveTimingPoints")
end

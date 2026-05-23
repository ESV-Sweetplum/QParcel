---@param e QueueElement
function queue.add(e)
    local function insertIfExists(tbl, item)
        if (not item) then return end
        table.insert(tbl, item)
    end

    local function insertManyIfExists(tbl, items)
        if (not items or not truthy(#items)) then return end
        for i = 1, #items do
            local item = items[i]
            table.insert(tbl, item)
        end
    end

    insertIfExists(queue.cur.bmsToAdd, e.AddBookmark)
    insertManyIfExists(queue.cur.bmsToAdd, e.AddBookmarkBatch)
    insertIfExists(queue.cur.bmsToRemove, e.RemoveBookmark)
    insertManyIfExists(queue.cur.bmsToRemove, e.RemoveBookmarkBatch)
end

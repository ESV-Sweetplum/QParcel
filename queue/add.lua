---@param e QueueElement
function queue.add(e)
    local function insertIfExists(tbl, item)
        if (item) then table.insert(tbl, item) end
    end

    local function insertManyIfExists(tbl, items)
        if (items and truthy(#items)) then
            for i = 1, #items do
                local item = items[i]
                table.insert(tbl, item)
            end
        end
    end

    insertIfExists(queue.cur.bmsToAdd, e.AddBookmark)
    insertManyIfExists(queue.cur.bmsToAdd, e.AddBookmarkBatch)
end

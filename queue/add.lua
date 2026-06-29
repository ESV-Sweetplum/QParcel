---@param e QueueElement
function queue.add(e)
    local function insertIfExists(tbl, key)
        local item = e[key]
        if not item then return end
        table.insert(tbl, item)
        queue.edited[key] = true
    end

    local function insertManyIfExists(tbl, key)
        local items = e[key]
        if not items then return end
        if not truthy(#items) then items = { items } end
        for i = 1, #items do
            local item = items[i]
            table.insert(tbl, item)
        end
        queue.edited[key] = true
    end

    insertManyIfExists(queue.cur.bmsToAdd, 'aBMs')
    insertManyIfExists(queue.cur.bmsToRemove, 'rBMs')

    insertManyIfExists(queue.cur.hosToAdd, 'aHOs')
    insertManyIfExists(queue.cur.hosToRemove, 'rHOs')

    insertIfExists(queue.cur.layersToAdd, 'aL')
    insertIfExists(queue.cur.layersToRemove, 'rL')

    insertManyIfExists(queue.cur.svsToAdd, 'aSVs')
    insertManyIfExists(queue.cur.svsToRemove, 'rSVs')

    insertManyIfExists(queue.cur.ssfsToAdd, 'aSSFs')
    insertManyIfExists(queue.cur.ssfsToRemove, 'rSSFs')

    insertIfExists(queue.cur.tgsToAdd, 'aTG')
    insertIfExists(queue.cur.tgsToRemove, 'rTG')

    insertManyIfExists(queue.cur.tpsToAdd, 'aTPs')
    insertManyIfExists(queue.cur.tpsToRemove, 'rTPs')
end

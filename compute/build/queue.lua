function compute.auxiliary.insertToQueue(thread)
    compute.queueProgress[thread.id] = 0
    local existingThreadIDs = table.map(compute.auxiliary.queue, function(e) return e.id end)
    if table.contains(existingThreadIDs, thread.id) then
        local queueIdx = table.indexOf(existingThreadIDs, thread.id)
        local finalFns = compute.auxiliary.queue[queueIdx].finalFn
        if type(finalFns) == 'function' then
            compute.auxiliary.queue[queueIdx].finalFn = { compute.auxiliary.queue[queueIdx].finalFn, thread.finalFn }
        elseif type(finalFns) == 'table' then
            table.insert(compute.auxiliary.queue[queueIdx].finalFn, thread.finalFn)
        else
            error('HOLY SHIT QUEUE ERROR PLEASE REPORT THIS')
        end
    else
        table.insert(compute.auxiliary.queue, thread)
    end
end

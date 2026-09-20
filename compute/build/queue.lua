function compute.auxiliary.insertToQueue(thread)
    compute.queueProgress[thread.id] = 0
    table.insert(compute.auxiliary.queue, thread)
end

compute.auxiliary.completed = false

if truthy(compute.auxiliary.queue) then
    local success = false
    local first = compute.auxiliary.queue[1]

    if compute.auxiliary.isFirstIter then
        compute.auxiliary.startedAt = state.UnixTime
        if first.args then
            success, compute.auxiliary.buf, compute.auxiliary.prog =
                coroutine.resume(first.cr, table.unpack(first.args))
        else
            success, compute.auxiliary.buf, compute.auxiliary.prog = coroutine.resume(first.cr)
        end
        compute.auxiliary.isFirstIter = false
    else
        success, compute.auxiliary.buf, compute.auxiliary.prog = coroutine.resume(first.cr, compute.auxiliary.buf)
    end

    compute.auxiliary.prog = compute.auxiliary.prog or 0
    compute.queueProgress[first.id] = compute.auxiliary.prog

    if coroutine.status(first.cr) == 'dead' then
        if compute.auxiliary.queue[1].finalFn then
            compute.auxiliary.queue[1].finalFn(compute.auxiliary.buf, state.UnixTime - compute.auxiliary.startedAt)
        end
        compute.queueProgress[first.id] = nil
        table.remove(compute.auxiliary.queue, 1)
        compute.auxiliary.result = compute.auxiliary.buf
        compute.auxiliary.buf = nil
        compute.auxiliary.prog = 0
        compute.auxiliary.isFirstIter = true
        compute.auxiliary.completed = true
    end
else
    compute.queueProgress = {}
end

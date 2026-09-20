function compute.wrap(id, fn, ...)
    local thread = compute.auxiliary.newEmptyThread(id)
    thread.id = id
    thread.cr = coroutine.create(fn)
    thread.args = table.pack(...)
    thread.onFinalize = function(f)
        thread.finalFn = f
        return thread
    end

    thread.build = function() compute.auxiliary.insertToQueue(thread) end

    return thread
end

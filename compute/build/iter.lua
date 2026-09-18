function compute.iter(id, arr)
    local thread = compute.auxiliary.newEmptyThread(id)
    local computeSize = 64

    thread.forEach = function(f)
        local newThr = thread
        local fn = function()
            local ct = #arr
            for idx, v in ipairs(arr) do
                f(v)
                if idx % computeSize == 0 then coroutine.yield('', idx / ct) end
            end
        end
        newThr.onFinalize = function(g)
            newThr.finalFn = g
            return newThr
        end

        newThr.cr = coroutine.create(fn)
        newThr.build = function() table.insert(compute.auxiliary.queue, thread) end

        return newThr
    end

    thread.reduce = function(f, init)
        local newThr = thread
        newThr.onFinalize = function(g)
            newThr.finalFn = g

            return newThr
        end
        local fn = function()
            local ct = #arr
            local r = init
            for idx, v in ipairs(arr) do
                r = f(r, v)
                if idx % computeSize == 0 then coroutine.yield('', idx / ct) end
            end

            return r
        end

        newThr.cr = coroutine.create(fn)
        newThr.build = function() table.insert(compute.auxiliary.queue, thread) end

        return newThr
    end

    return thread
end

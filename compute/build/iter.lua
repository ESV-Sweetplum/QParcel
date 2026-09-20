function compute.iter(id, arr)
    local thread = compute.auxiliary.newEmptyThread(id)
    local computeSize = 1000

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
        newThr.build = function() compute.auxiliary.insertToQueue(thread) end

        return newThr
    end

    thread.filter = function(f)
        local newThr = thread
        local fn = function()
            local ct = #arr
            local out = {}
            for idx, v in ipairs(arr) do
                if f(v) then out[#out + 1] = v end
                if idx % computeSize == 0 then coroutine.yield('', idx / ct) end
            end

            return out
        end
        newThr.onFinalize = function(g)
            newThr.finalFn = g
            return newThr
        end

        newThr.cr = coroutine.create(fn)
        newThr.build = function() compute.auxiliary.insertToQueue(thread) end

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
        newThr.build = function() compute.auxiliary.insertToQueue(thread) end

        return newThr
    end

    return thread
end

function compute.iter2(id, arr)
    local thread = compute.auxiliary.newEmptyThread(id)
    local computeSize = 1000

    thread.reduce = function(f, init)
        local newThr = thread
        newThr.onFinalize = function(g)
            newThr.finalFn = g

            return newThr
        end
        local fn = function()
            local ct = #arr
            local r = init
            local prev = arr[1]
            for i = 2, ct do
                local this = arr[i]
                r = f(r, this, prev)
                if i % computeSize == 0 then coroutine.yield('', i / ct) end
                prev = this
            end

            return r
        end

        newThr.cr = coroutine.create(fn)
        newThr.build = function() compute.auxiliary.insertToQueue(thread) end

        return newThr
    end

    return thread
end

function compute.auxiliary.newEmptyThread(id)
    return {
        id = id,
        cr = nil,
        finalFn = nil,
        build = function() end,
    }
end

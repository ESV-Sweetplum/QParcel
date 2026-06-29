function queue.reset()
    queue = {
        cur = {
            hosToAdd = {}, ---@type HitObject[]
            hosToRemove = {}, ---@type HitObject[]
            layersToAdd = {}, ---@type EditorLayer[]
            layersToRemove = {}, ---@type EditorLayer[]
            bmsToAdd = {}, ---@type Bookmark[]
            bmsToRemove = {}, ---@type Bookmark[]
            svsToAdd = {}, ---@type ScrollVelocity[]
            svsToRemove = {}, ---@type ScrollVelocity[]
            tpsToAdd = {}, ---@type TimingPoint[]
            tpsToRemove = {}, ---@type TimingPoint[]
            ssfsToAdd = {}, ---@type ScrollSpeedFactor[]
            ssfsToRemove = {}, ---@type ScrollSpeedFactor[]
            tgsToAdd = {}, ---@type ScrollGroup[]
            tgsToRemove = {} ---@type ScrollGroup[]
        },
        edited = {}
    }
end

queue.reset()

---comment
---@param ct integer
---@param s integer
---@param e integer
---@param first HitObject
function game.internal.updateSelectionData(ct, s, e, first, timeCount)
    game.selection.count = ct
    game.selection.firstOffset = s
    game.selection.lastOffset = e

    game.selection.noteSelected = timeCount > 0
    game.selection.regionSelected = timeCount > 1
    game.selection.multiRegionSelected = timeCount > 2

    game.selection.duration = e - s

    if ct > 0 then game.selection.firstHitObject = first end
end

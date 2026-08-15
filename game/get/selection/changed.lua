game.selection.count = 0
game.selection.startOffset = -1
game.selection.endOffset = -1
game.selection.firstHitObject = nil

---Returns true if the user's selection has changed.
function game.get.selectionChanged()
    local changed = false

    local hos = state.SelectedHitObjects
    local selectionCount = 0
    for _, _ in pairs(state.SelectedHitObjects) do
        selectionCount = selectionCount + 1
    end

    local firstHitObject = hos[1]
    local lastHitObject = hos[#hos]
    local startOffset = firstHitObject and firstHitObject.StartTime or -1
    local endOffset = lastHitObject and lastHitObject.StartTime or -1

    if
        selectionCount ~= game.selection.count
        or startOffset ~= game.selection.startOffset
        or endOffset ~= game.selection.endOffset
    then
        game.internal.updateSelectionData(selectionCount, startOffset, endOffset)
        return true
    end

    return false
end

function game.internal.updateSelectionData(ct, s, e)
    game.selection.count = ct
    if s then game.selection.startOffset = s end
    if e then game.selection.endOffset = e end
    if ct > 0 then game.selection.firstHitObject = state.SelectedHitObjects[1] end
end

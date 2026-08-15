---Returns true if the user's selection has changed.
function game.get.selectionChanged()
    local selectionData = {
        oldStartOffset = -1,
        oldEndOffset = -1,
        oldSelectionCount = -1,
    }

    local changed = false

    cache.load('QParcel.internal.selectionData', selectionData)

    local hos = state.SelectedHitObjects
    local selectionCount = #hos
    if selectionCount ~= selectionData.oldSelectionCount then changed = true end
    selectionData.oldSelectionCount = #hos
    local firstHitObject = hos[1]
    local lastHitObject = hos[#hos]
    local startOffset = firstHitObject and firstHitObject.StartTime or -1
    local endOffset = lastHitObject and lastHitObject.StartTime or -1

    if startOffset ~= selectionData.oldStartOffset or endOffset ~= selectionData.oldEndOffset then changed = true end

    selectionData.oldStartOffset = startOffset
    selectionData.oldEndOffset = endOffset

    cache.save('QParcel.internal.selectionData', selectionData)

    return changed
end

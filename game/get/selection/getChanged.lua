game.selection.count = 0
game.selection.firstOffset = -1
game.selection.lastOffset = -1
game.selection.firstHitObject = nil
game.selection.noteSelected = false
game.selection.regionSelected = false
game.selection.multiRegionSelected = false
game.selection.duration = 0

---Returns true if the user's selection has changed.
function game.get.selectionChanged()
    local changed = false

    local hos = state.SelectedHitObjects
    local selectionCount = #hos

    local firstHitObject = hos[1]
    local lastHitObject = hos[#hos]
    local firstOffset = firstHitObject and firstHitObject.StartTime or -1
    local lastOffset = lastHitObject and lastHitObject.StartTime or -1

    if
        selectionCount ~= game.selection.count
        or firstOffset ~= game.selection.firstOffset
        or lastOffset ~= game.selection.lastOffset
    then
        local times = game.get.uniqueSelectedNoteOffsets()

        game.internal.updateSelectionData(selectionCount, firstOffset, lastOffset, firstHitObject, #times or 0)
        return true
    end

    return false
end

function queue.execute()
    local actionList = {}
    local cur, edit, ea = queue.cur, queue.edited, utils.CreateEditorAction

    if (edit.bmsToAdd) then
        table.insert(actionList, ea(action_type.AddBookmarkBatch, cur.bmsToAdd))
    end
    if (edit.bmsToRemove) then
        table.insert(actionList, ea(action_type.RemoveBookmarkBatch, cur.bmsToRemove))
    end

    if (edit.hosToAdd) then
        table.insert(actionList, ea(action_type.PlaceHitObjectBatch, cur.hosToAdd))
    end
    if (edit.hosToRemove) then
        table.insert(actionList, ea(action_type.RemoveHitObjectBatch, cur.hosToRemove))
    end

    if (edit.svsToAdd) then
        table.insert(actionList, ea(action_type.AddScrollVelocityBatch, cur.svsToAdd))
    end
    if (edit.svsToRemove) then
        table.insert(actionList, ea(action_type.RemoveScrollVelocityBatch, cur.svsToRemove))
    end

    if (edit.ssfsToAdd) then
        table.insert(actionList, ea(action_type.AddScrollSpeedFactorBatch, cur.ssfsToAdd))
    end
    if (edit.ssfsToRemove) then
        table.insert(actionList, ea(action_type.RemoveScrollSpeedFactorBatch, cur.ssfsToRemove))
    end

    if (edit.tpsToAdd) then
        table.insert(actionList, ea(action_type.AddTimingPointBatch, cur.tpsToAdd))
    end
    if (edit.tpsToRemove) then
        table.insert(actionList, ea(action_type.RemoveTimingPointBatch, cur.tpsToRemove))
    end

    actions.PerformBatch(actionList)
    queue.reset()
end

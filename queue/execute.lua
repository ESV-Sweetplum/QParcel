function queue.execute()
    local actionList = {}
    local cur, edit, ea = queue.cur, queue.edited, utils.CreateEditorAction

    if edit.aBMs then table.insert(actionList, ea(action_type.AddBookmarkBatch, cur.bmsToAdd)) end
    if edit.rBMs then table.insert(actionList, ea(action_type.RemoveBookmarkBatch, cur.bmsToRemove)) end

    if edit.aHOs then table.insert(actionList, ea(action_type.PlaceHitObjectBatch, cur.hosToAdd)) end
    if edit.rHOs then table.insert(actionList, ea(action_type.RemoveHitObjectBatch, cur.hosToRemove)) end

    if edit.aSVs then table.insert(actionList, ea(action_type.AddScrollVelocityBatch, cur.svsToAdd)) end
    if edit.rSVs then table.insert(actionList, ea(action_type.RemoveScrollVelocityBatch, cur.svsToRemove)) end

    if edit.aSSFs then table.insert(actionList, ea(action_type.AddScrollSpeedFactorBatch, cur.ssfsToAdd)) end
    if edit.rSSFs then table.insert(actionList, ea(action_type.RemoveScrollSpeedFactorBatch, cur.ssfsToRemove)) end

    if edit.aTPs then table.insert(actionList, ea(action_type.AddTimingPointBatch, cur.tpsToAdd)) end
    if edit.rTPs then table.insert(actionList, ea(action_type.RemoveTimingPointBatch, cur.tpsToRemove)) end

    actions.PerformBatch(actionList)
    queue.reset()
end

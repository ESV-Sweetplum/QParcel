---Returns an array of all timing group ids, including `$DEFAULT` and `$GLOBAL`.
---@return string[]
function game.get.timingGroupList()
    local baseList = table.keys(map.TimingGroups)
    local defaultIndex = table.indexOf(baseList, '$Default')
    table.remove(baseList, defaultIndex)

    local globalIndex = table.indexOf(baseList, '$Global')
    table.remove(baseList, globalIndex)

    table.insert(baseList, 1, '$Default')
    table.insert(baseList, 2, '$Global')

    return baseList
end

function game.get.timingGroupsAndColors(hideFn)
    local groups = { '$Default', '$Global' }
    local cols = { map.TimingGroups['$Default'].ColorRgb or '86,253,110', map.TimingGroups['$Global'].ColorRgb or
    '255,255,255' }
    local hiddenGroups = {}
    for tgId, tg in pairs(map.TimingGroups) do
        if string.find(tgId, '%$') then goto nextTG end
        if (hideFn(tgId)) then
            table.insert(hiddenGroups,
                tgId)
        end
        table.insert(groups, tgId)
        table.insert(cols, tg.ColorRgb or '255,255,255')
        ::nextTG::
    end

    return groups, cols, hiddenGroups
end

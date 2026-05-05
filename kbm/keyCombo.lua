require('packages.table.contains')

---Returns true if the given key combo returns true depending on the given function (e.g. "Ctrl+Shift+L")
---@param keyCombo string
---@param type "down" | "pressed"
---@return boolean
function kbm.keyComboCheck(keyCombo, type)
    if (imgui.IsAnyItemActive() or not keyCombo or keyCombo == 'NONE') then return false end
    keyCombo = keyCombo:upper()
    local comboList = {}
    for v in keyCombo:gmatch('[%u%d]+') do
        table.insert(comboList, v)
    end
    comboList = sort(comboList, function(a, b)
        return a:len() > b:len()
    end)
    local keyReq = comboList[#comboList]
    local ctrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local shiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local altHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)

    local requiresCtrl = table.contains(comboList, 'CTRL')
    local requiresShift = table.contains(comboList, 'SHIFT')
    local requiresAlt = table.contains(comboList, 'ALT')
    if (requiresCtrl ~= ctrlHeld) then
        return false
    end
    if (requiresShift ~= shiftHeld) then
        return false
    end
    if (requiresAlt ~= altHeld) then
        return false
    end
    if (keyReq:len() > 1) then
        if (type == 'down') then return true end

        local ctrlPressed = utils.IsKeyPressed(keys.LeftControl) or utils.IsKeyPressed(keys.RightControl)
        local shiftPressed = utils.IsKeyPressed(keys.LeftShift) or utils.IsKeyPressed(keys.RightShift)
        local altPressed = utils.IsKeyPressed(keys.LeftAlt) or utils.IsKeyPressed(keys.RightAlt)

        if (ctrlPressed and requiresCtrl) then return true end
        if (shiftPressed and requiresShift) then return true end
        if (altPressed and requiresAlt) then return true end

        return false
    end
    local keyReqNum = keys[keyReq]
    if keyReq:find('^%d$') then
        keyReqNum = tn(keyReq) + 48
    end
    if not keyReqNum then
        return false
    end
    local fnTable = {
        down = utils.IsKeyDown,
        pressed = utils.IsKeyPressed,
    }
    return fnTable[type](keyReqNum)
end

function kbm.pressedKeyCombo(keyCombo)
    return kbm.keyComboCheck(keyCombo, 'pressed')
end

function kbm.holdingKeyCombo(keyCombo)
    return kbm.keyComboCheck(keyCombo, 'down')
end

kbm.executedKeyCombo = kbm.pressedKeyCombo
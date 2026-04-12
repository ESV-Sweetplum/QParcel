---Returns the `i`-th character in a string. Simply used for shorthand. Also supports negative indexes.
---@param str string The string to search.
---@param i integer If positive, returns the `i`th character. If negative, returns the `i`th character from the end of the string (e.g. -1 returns the last character).
---@return string
function string.charAt(str, i)
    return str:sub(i, i)
end

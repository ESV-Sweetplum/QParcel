---Returns a value between 0 to 1 using [Jaro-Winkler distance](https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance).
---@param str1 string
---@param str2 string
---@return number
function string.compare(str1, str2)
    if str1 == str2 then return 1 end

    local len1, len2 = str1:len(), str2:len()
    local maxDist = math.floor(math.max(len1, len2) / 2)

    local matches = 0
    local str1Tbl = table.constructRepeating(0, len1)
    local str2Tbl = table.constructRepeating(0, len1)

    for i = 1, len1 do
        for j = math.max(1, i - maxDist), math.min(len2, i + maxDist) do
            if str1:charAt(i) == str2:charAt(j) and str2Tbl[j] == 0 then
                str1Tbl[i] = 1
                str2Tbl[j] = 1
                matches = matches + 1
                break
            end
        end
    end

    if matches == 0 then return 0 end

    local transpositions = 0
    local point = 1

    for i = 1, len1 do
        if str1Tbl[i] > 0 then
            while str2Tbl[point] == 0 do
                point = point + 1
            end
            if str1:charAt(i) ~= str2:charAt(point) then transpositions = transpositions + 1 end
            point = point + 1
        end
    end

    transpositions = transpositions / 2

    return 1 / 3 * (matches / len1 + matches / len2 + (matches - transpositions) / matches)
end

local mapping = {}

local M = {}

M.__reset = function()
    mapping = {}
end

M.__get_mapping = function(word)
    return mapping[word]
end

M.__register = function(list)
    for i, value in ipairs(list) do
        if i == #list then
            mapping[value] = list[1]
        else
            mapping[value] = list[i + 1]
        end
    end
end

M.__has_mapping = function(word)
    return mapping[word] ~= nil
end

return M

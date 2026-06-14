local mapping = {}

local M = {}

M.__reset = function()
    mapping = {}
end

M.__get_mapping = function(word)
    return mapping[word]
end

M.__get_previous_mapping = function(word)
    -- cycle till the original word and get previous one
    local next_word = word
    while next_word ~= mapping[next_word] do
        next_word = mapping[next_word]

        if mapping[next_word] == word then
            return next_word
        end
    end
end

M.__register = function(list)
    for i, value in ipairs(list or {}) do
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

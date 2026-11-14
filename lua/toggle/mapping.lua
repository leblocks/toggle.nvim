local mapping = {}
local mapping_by_filetype = {}

local M = {}

local function get_map(filetype)
    if filetype == nil then
        return mapping
    end

    -- init with empty table
    if not mapping_by_filetype[filetype] then
        mapping_by_filetype[filetype] = {}
    end

    return mapping_by_filetype[filetype]
end

M.__reset = function()
    mapping = {}
    mapping_by_filetype = {}
end

M.__get_mapping = function(word, filetype)
    return get_map(filetype)[word] or get_map()[word]
end

M.__get_previous_mapping = function(word, filetype)
    -- cycle till the original word and get previous one
    local next_word = word
    while next_word ~= get_map(filetype)[next_word] do
        next_word = get_map(filetype)[next_word]

        if get_map(filetype)[next_word] == word then
            return next_word
        end
    end
end

M.__register = function(list, filetype)
    for i, value in ipairs(list or {}) do
        if i == #list then
            get_map(filetype)[value] = list[1]
        else
            get_map(filetype)[value] = list[i + 1]
        end
    end
end

M.__has_mapping = function(word, filetype)
    return get_map(filetype)[word] ~= nil or get_map()[word] ~= nil
end

return M

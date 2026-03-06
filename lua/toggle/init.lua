local mapping = require('toggle.mapping')
local defaults = require('toggle.defaults')
local replacer = require('toggle.replacer')

local M = {}

---@class ToggleConfiguration
---@field defaults boolean Include built-in toggle pairs
---@field mappings table Additional toggle pairs
---@field keep_cursor_position boolean Restore cursor position after toggling a word
local config = {
    defaults = true,
    mappings = {},
    keep_cursor_position = true,
}

--- @param opts? ToggleConfiguration
function M.setup(opts)
    opts = opts or {}

    config.keep_cursor_position = opts.keep_cursor_position ~= false

    mapping.__reset()

    if opts.defaults ~= false then
        for _, pair in ipairs(defaults) do
            mapping.__register(pair)
        end
    end

    if opts.mappings then
        for _, pair in ipairs(opts.mappings) do
            mapping.__register(pair)
        end
    end
end

function M.toggle()
    local replacers = {
        replacer.__cWORD_replacer(),
        replacer.__cword_replacer(),
        replacer.__character_replacer(),
    }

    local current_cursor_position = vim.fn.getcurpos()

    for _, r in ipairs(replacers) do
        if r.can_handle() then
            r.replace()
            if config.keep_cursor_position then
                vim.fn.setpos('.', current_cursor_position)
            end
            return
        end
    end
end

M.setup()

return M

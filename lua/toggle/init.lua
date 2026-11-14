local mapping = require('toggle.mapping')
local defaults = require('toggle.defaults')
local replacer = require('toggle.replacer')

local M = {}

local register_table = function(mappings, filetype)
    for _, map in ipairs(mappings) do
        mapping.__register(map, filetype)
    end
end

---@class ToggleConfiguration
---@field defaults? boolean Include built-in toggle pairs
---@field mappings? table<integer, string[]> Additional general toggle pairs
---@field mappings_by_filetype? table<string, table<integer, string[]>> Additional toggle pairs grouped by filetype
---@field keep_cursor_position? boolean Restore cursor position after toggling a word
local config = {
    defaults = true,
    mappings = {},
    mappings_by_filetype = {},
    keep_cursor_position = true,
}

--- @param opts? ToggleConfiguration
function M.setup(opts)
    opts = opts or {}

    config.keep_cursor_position = opts.keep_cursor_position ~= false

    mapping.__reset()

    if opts.defaults ~= false then
        -- load default mapping
        register_table(defaults)
        register_table(require('toggle.defaults.lua'), 'lua')
        register_table(require('toggle.defaults.powershell'), 'ps1')
        register_table(require('toggle.defaults.csharp'), 'cs')
    end

    if opts.mappings then
        register_table(opts.mappings)
    end

    if opts.mappings_by_filetype then
        for ft, map in pairs(opts.mappings_by_filetype) do
            register_table(map, ft)
        end
    end
end

function M.toggle(toggle_backwards)
    local replacers = {
        replacer.__visual_mode_replacer,
        replacer.__get_cWORD_replacer,
        replacer.__get_cword_replacer,
        replacer.__get_end_of_word_replacer,
        replacer.__get_character_replacer,
    }

    local mapper = mapping.__get_mapping

    if toggle_backwards then
        mapper = mapping.__get_previous_mapping
    end

    local current_filetype = vim.bo.filetype
    local current_cursor_position = vim.fn.getcurpos()

    for _, get_replacer in ipairs(replacers) do
        local r = get_replacer()
        if r.can_handle(current_filetype) then
            r.replace(mapper, current_filetype)
            if config.keep_cursor_position then
                vim.fn.setpos('.', current_cursor_position)
            end
            return
        end
    end
end

M.setup()

return M

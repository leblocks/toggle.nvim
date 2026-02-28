
local mapping = require('toggle.mapping')
local defaults = require('toggle.defaults')

local M = {}

---@class ToggleConfiguration
---@field defaults boolean Include built-in toggle pairs
---@field mappings table Additional toggle pairs

--- @param opts? ToggleConfiguration
function M.setup(opts)
  opts = opts or {}

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
  local word_under_cursor = vim.fn.expand('<cword>')

  if mapping.__has_mapping(word_under_cursor) then
    vim.api.nvim_command('normal! ciw' .. mapping.__get_mapping(word_under_cursor))
    return
  end

  -- fall back to single character under cursor
  local coords = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local character_under_cursor = line:sub(coords[2] + 1, coords[2] + 1)

  if mapping.__has_mapping(character_under_cursor) then
    vim.api.nvim_command('normal! r' .. mapping.__get_mapping(character_under_cursor))
    return
  end
end

M.setup()

return M


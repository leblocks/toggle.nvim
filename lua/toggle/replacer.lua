local mapping = require('toggle.mapping')

local M = {}

M.__cword_replacer = function()
    return {
        can_handle = function()
            local word = vim.fn.expand('<cword>')
            return mapping.__has_mapping(word)
        end,

        replace = function()
            local word = vim.fn.expand('<cword>')
            vim.api.nvim_command('normal! ciw' .. mapping.__get_mapping(word))
        end,
    }
end

M.__cWORD_replacer = function()
    return {
        can_handle = function()
            local word = vim.fn.expand('<cWORD>')
            return mapping.__has_mapping(word)
        end,

        replace = function()
            local word = vim.fn.expand('<cWORD>')
            vim.api.nvim_command('normal! ciW' .. mapping.__get_mapping(word))
        end,
    }
end

M.__character_replacer = function()
    return {
        can_handle = function()
            local character = M.__get_character_under_cursor()
            return mapping.__has_mapping(character)
        end,

        replace = function()
            local character = M.__get_character_under_cursor()
            vim.api.nvim_command('normal! r' .. mapping.__get_mapping(character))
        end,
    }
end

-- TODO write tests
M.__get_character_under_cursor = function()
    local coords = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    return line:sub(coords[2] + 1, coords[2] + 1)
end

return M

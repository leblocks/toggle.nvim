local mapping = require('toggle.mapping')

-- TODO provide luadocs for replacers
local M = {}

M.__get_cword_replacer = function()
    local word = vim.fn.expand('<cword>')
    return {
        can_handle = function()
            return mapping.__has_mapping(word)
        end,

        replace = function()
            vim.api.nvim_command('normal! ciw' .. mapping.__get_mapping(word))
        end,
    }
end

M.__get_cWORD_replacer = function()
    local word = vim.fn.expand('<cWORD>')
    return {
        can_handle = function()
            return mapping.__has_mapping(word)
        end,

        replace = function()
            vim.api.nvim_command('normal! ciW' .. mapping.__get_mapping(word))
        end,
    }
end

M.__get_character_replacer = function()
    local coords = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local character = line:sub(coords[2] + 1, coords[2] + 1)

    return {
        can_handle = function()
            return mapping.__has_mapping(character)
        end,

        replace = function()
            vim.api.nvim_command('normal! r' .. mapping.__get_mapping(character))
        end,
    }
end

M.__get_end_of_word_replacer = function()
    local current_cursor_position = vim.fn.getcurpos()
    vim.api.nvim_command('normal! e') -- jump to the end of word

    local end_of_word_column = vim.api.nvim_win_get_cursor(0)[2]
    vim.fn.setpos('.', current_cursor_position) -- restore cursor position

    local line = vim.api.nvim_get_current_line()
    local end_of_word_under_cursor = line:sub(current_cursor_position[3], end_of_word_column + 1)

    return {
        can_handle = function()
            return mapping.__has_mapping(end_of_word_under_cursor)
        end,

        replace = function()
            vim.api.nvim_command('normal! ce' .. mapping.__get_mapping(end_of_word_under_cursor))
        end,
    }
end

M.__visual_mode_replacer = function()

    local mode = vim.api.nvim_get_mode().mode
    local selected_text = ''
    if mode == 'v' or mode == 'V' then
        local vstart = vim.fn.getpos(".")
        local vend = vim.fn.getpos("v")
        local lines = vim.fn.getregion(vstart, vend)
        selected_text = lines[1]
    end

    return {
        can_handle = function()
            return (mode == 'v' or mode == 'V') and mapping.__has_mapping(selected_text)
        end,

        replace = function()
            vim.api.nvim_command('norm! c' .. mapping.__get_mapping(selected_text))
        end,
    }
end

return M

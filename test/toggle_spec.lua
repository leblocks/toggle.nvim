local toggle = require('toggle')

local function open_file_at(file_to_open, row, column, callback)
    local full_path = vim.fs.joinpath(vim.fn.getcwd(), file_to_open)
    vim.api.nvim_command('edit ' .. full_path)
    vim.api.nvim_win_set_cursor(0, { row, column })
    callback()
    vim.cmd(':bd!')
end

local function get_character_under_cursor()
    local coords = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    return line:sub(coords[2] + 1, coords[2] + 1)
end

describe('toggle', function()
    it('toggle cword', function()
        open_file_at('test/test_files/test_1.txt', 1, 1, function()
            toggle.toggle()
            assert(vim.fn.expand('<cword>') == 'true')
        end)
    end)

    it('toggle cWORD', function()
        open_file_at('test/test_files/test_1.txt', 2, 1, function()
            toggle.toggle()
            assert(vim.fn.expand('<cword>') == 'true')
        end)
    end)

    it('toggle char', function()
        open_file_at('test/test_files/test_1.txt', 3, 1, function()
            toggle.toggle()
            assert(get_character_under_cursor() == '>')
        end)
    end)
end)

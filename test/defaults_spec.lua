local defaults = require('toggle.defaults')
local lua_defaults = require('toggle.defaults.lua')
local csharp_defaults = require('toggle.defaults.csharp')
local ps_defaults = require('toggle.defaults.powershell')
local python_defaults = require('toggle.defaults.python')
local js_defaults = require('toggle.defaults.javascript')

local function check_no_duplicates(mappings, label)
    local seen = {}
    for _, mapping in ipairs(mappings) do
        for _, word in ipairs(mapping) do
            if seen[word] then
                print('has duplicate mapping in ' .. label .. ' for ' .. word)
                assert(false)
            else
                seen[word] = true
            end
        end
    end
end

describe('defaults', function()
    it('no duplicates in general mappings', function()
        check_no_duplicates(defaults, 'general')
    end)

    it('no duplicates in lua mappings', function()
        check_no_duplicates(lua_defaults, 'lua')
    end)

    it('no duplicates in csharp mappings', function()
        check_no_duplicates(csharp_defaults, 'csharp')
    end)

    it('no duplicates in powershell mappings', function()
        check_no_duplicates(ps_defaults, 'powershell')
    end)

    it('no duplicates in python mappings', function()
        check_no_duplicates(python_defaults, 'python')
    end)

    it('no duplicates in javascript mappings', function()
        check_no_duplicates(js_defaults, 'javascript')
    end)
end)

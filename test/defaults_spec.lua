local defaults = require('toggle.defaults')

describe('defaults', function()
    it('no duplicates in mappings', function()
        local seen = {}
        for _, mapping in ipairs(defaults) do
            for _, word in ipairs(mapping) do
                if seen[word] then
                    assert(false)
                else
                    seen[word] = true
                end
            end
        end
    end)
end)

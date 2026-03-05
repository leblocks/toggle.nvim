local mapping = require('toggle.mapping')

describe('mapping', function()
    it('__reset clears mapping', function()
        mapping.__register({ 'foo', 'bar' })
        mapping.__reset()
        assert(mapping.__has_mapping('foo') == false)
        assert(mapping.__has_mapping('bar') == false)
    end)

    it('__get_mapping - existing mapping', function()
        -- TODO
    end)

    it('__get_mapping - non-existing mapping', function()
        -- TODO
    end)

    it('__register - empty', function()
        -- TODO
    end)

    it('__register - null', function()
        -- TODO
    end)

    it('__register - happy path', function()
        -- TODO
    end)

    it('__has_mapping - existing map', function()
        mapping.__reset()
        mapping.__register({ 'foo', 'bar' })
        assert(mapping.__has_mapping('foo'))
        assert(mapping.__has_mapping('bar'))
    end)

    it('__has_mapping - nil', function()
        assert(mapping.__has_mapping(nil) == false)
    end)
end)


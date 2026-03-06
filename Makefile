.PHONY: prepare test lint

prepare:
	git clone --depth 1 https://github.com/nvim-lua/plenary.nvim .ci/vendor/pack/vendor/start/plenary.nvim

test:
	nvim --headless --clean -u scripts/minimal_init.lua -c "PlenaryBustedDirectory test/ { minimal_init = 'scripts/minimal_init.lua', sequential = true }"

lint:
	luacheck lua/toggle


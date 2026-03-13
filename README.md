# toggle.nvim

A Neovim plugin to toggle words under the cursor to their counterpart (e.g., `true` → `false`, `public` → `protected` → `private`).

[![bmEeX.gif](https://s13.gifyu.com/images/bmEeX.gif)](https://gifyu.com/image/bmEeX)

## Installation

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use({ 'leblocks/toggle.nvim', })
```

## Configuration

```lua
require('toggle').setup({
  -- Include built-in toggle pairs (default: true)
  defaults = true,

  -- Restore cursor position after toggling a word (default: true)
  keep_cursor_position = true,

  -- Additional toggle pairs (merged with defaults)
  mappings = {
    { 'yes', 'no' },
    { 'foo', 'bar', 'baz' },  -- cycles: foo → bar → baz → foo
  },
})
```

### Options

| Option     | Type    | Default | Description                          |
|------------|---------|---------|--------------------------------------|
| `defaults` | boolean | `true`  | Include built-in toggle pairs        |
| `keep_cursor_position` | boolean | `true` | Restore cursor position after toggling a word |
| `mappings` | table   | `{}`    | Additional toggle pairs to register  |

## Usage

### Keymap example

```lua
-- v for visual mode, if needed
vim.keymap.set({ 'n', 'v' }, '<leader>t', require('toggle').toggle, { desc = 'Toggle word' })
```

## How it works

1. Gets the **word** under the cursor and checks for a mapping → replaces with `ciw` / `ciW`
2. Falls back to the single **character** under the cursor → replaces with `r`
3. Also works for visual mode, in such case selection is being checked
4. Also checks if end of word matches anything in mappings and toggles it

Mappings are circular: for a group like `{ 'public', 'protected', 'private' }`, each value cycles to the next, and the last wraps to the first.

## Default mappings

See [lua/toggle/defaults.lua](lua/toggle/defaults.lua) for the full list of built-in toggle pairs.


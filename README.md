# toggle.nvim

A Neovim plugin to toggle words under the cursor to their counterpart (e.g., `true` → `false`, `public` → `protected` → `private`).

[![bvT1Q.gif](https://s13.gifyu.com/images/bv5lv.gif)](https://s13.gifyu.com/images/bv5lv.gif)

## Installation

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use({ 'leblocks/toggle.nvim', })

## Configuration

```lua
require('toggle').setup({
  -- Include built-in toggle pairs (default: true)
  defaults = true,

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
| `mappings` | table   | `{}`    | Additional toggle pairs to register  |

## Usage

### Keymap example

```lua
vim.keymap.set('n', '<leader>t', require('toggle').toggle, { desc = 'Toggle word' })
```

## How it works

1. Gets the **word** under the cursor and checks for a mapping → replaces with `ciw`
2. Falls back to the single **character** under the cursor → replaces with `r`

Mappings are circular: for a group like `{ 'public', 'protected', 'private' }`, each value cycles to the next, and the last wraps to the first.

## Default mappings

| Toggle group                              |
|-------------------------------------------|
| `[` ↔ `]`                                |
| `(` ↔ `)`                                |
| `{` ↔ `}`                                |
| `-` ↔ `+`                                |
| `<` ↔ `>`                                |
| `'` ↔ `"`                                |
| `&&` ↔ `\|\|`                            |
| `or` ↔ `and`                             |
| `get` ↔ `set`                            |
| `on` ↔ `off`                             |
| `all` ↔ `none`                           |
| `allow` ↔ `deny`                         |
| `true` ↔ `false`                         |
| `$True` ↔ `$False`                       |
| `enable` ↔ `disable`                     |
| `Enable` ↔ `Disable`                     |
| `enabled` ↔ `disabled`                   |
| `Enabled` ↔ `Disabled`                   |
| `public` → `protected` → `private`       |
| `IsTrue` ↔ `IsFalse`                     |
| `IsNull` ↔ `IsNotNull`                   |


# 🔄 toggle.nvim

[![CI](https://img.shields.io/github/actions/workflow/status/leblocks/toggle.nvim/ci.yml?branch=master&label=CI&style=flat-square)](https://github.com/leblocks/toggle.nvim/actions)

Instantly toggle words under your cursor to their semantic counterparts in a seamless, circular cycle. 

Whether you're swapping `true` to `false`, cycling through `public` → `protected` → `private`, or switching operators like `==` to `!=`, **toggle.nvim** handles it smartly, predictably, and without losing your cursor position.

## ✨ Features

- **Multi-Step Circular Cycling:** Go beyond simple booleans. Cycle through 3+ state chains (e.g., `info` → `warn` → `error` → `fatal`).
- **Bi-directional:** Toggle forwards or backwards seamlessly.
- **Smart Matching Engine:** Intelligently evaluates the word under the cursor. Supports Visual selections, `cWORD`, `cword`, end-of-word (`ce`), and single-character matches.
- **Cursor Preservation:** Your cursor stays exactly where it belongs, maintaining its relative position during replacements.
- **Zero Dependencies:** Extremely lightweight and fast.
- **Highly Extensible:** Ship with sensible built-in defaults, but easily merge your own custom pairs.

## 🎥 Demonstration

[![bmEeX.gif](https://s13.gifyu.com/images/bmEeX.gif)](https://gifyu.com/image/bmEeX)

## 📦 Installation

Install `toggle.nvim` with your preferred package manager.

**vim.pack**
```lua
vim.pack.add({ 'https://github.com/leblocks/toggle.nvim' })
```

**[lazy.nvim](https://github.com/folke/lazy.nvim):**
```lua
{
  "leblocks/toggle.nvim",
  config = true,
  -- Optional: Define keymaps here via lazy's keys property
}
```

**[packer.nvim](https://github.com/wbthomason/packer.nvim):**
```lua
use {
  "leblocks/toggle.nvim",
  config = function()
    require("toggle").setup()
  end
}
```

## 🚀 Quick Setup & Keymaps

Call the `setup()` function and map your preferred keys.

```lua
-- In your init.lua or keymaps.lua
require("toggle").setup({
  -- Optional: Override default settings here
})

-- Forward toggle
vim.keymap.set("n", "t", function()
  require("toggle").toggle()
end, { desc = "Toggle word (Forward)" })

-- Backward toggle (pass `true` to reverse direction)
vim.keymap.set("n", "T", function()
  require("toggle").toggle(true)
end, { desc = "Toggle word (Backward)" })
```

## ⚙️ Configuration Reference

You can pass a configuration table to `setup()`. Here are the available options and their defaults:

| Option | Type | Default | Description |
| :--- | :---: | :---: | :--- |
| `defaults` | `boolean` | `true` | If `true`, loads the plugin's built-in default mappings (e.g., true/false, on/off). |
| `keep_cursor_position`| `boolean` | `true` | Maintains the cursor's relative horizontal position after the replacement. |
| `mappings` | `table` | `{}` | A list of tables containing your custom cyclic mappings. Merges with defaults. |

## 🛠️ Advanced Usage & Custom Mappings

Adding your own custom vocabulary is trivial. Just provide arrays of strings in the `mappings` table. The plugin automatically wires them up as circular chains.

```lua
require("toggle").setup({
  defaults = true, -- Keep the built-in mappings
  mappings = {
    -- Custom boolean variants
    { "yes", "no", "maybe" },
    { "Yes", "No", "Maybe" },
    
    -- Logging levels
    { "DEBUG", "INFO", "WARN", "ERROR", "FATAL" },
    
    -- CSS properties
    { "flex-start", "center", "flex-end", "space-between", "space-around" },
    
    -- Framework specific (e.g., React states)
    { "useState", "useEffect", "useContext", "useReducer" },
  }
})
```

## 🧠 How It Works (Matching Priority)

To ensure the exact text you want is toggled, the matching engine evaluates the text at your cursor in the following fallback order:

1. **Visual Selection:** The explicitly highlighted text (if triggered from Visual mode).
2. **`cWORD`:** The full continuous string of non-blank characters.
3. **`cword`:** The standard alphanumeric word under the cursor.
4. **End-of-word (`ce`):** Catches edge cases when the cursor is at the tail of a word.
5. **Single Character (`r`):** Falls back to replacing the exact character under the cursor (useful for single-character operators).

Mappings are circular: for a group like `{ 'public', 'protected', 'private' }`, each value cycles to the next, and the last wraps to the first.

## Default mappings

See [lua/toggle/defaults.lua](lua/toggle/defaults.lua) for the full list of built-in toggle pairs.

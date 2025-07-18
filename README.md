
# nvim-dictionary

A simple Neovim plugin to download and sync a local English dictionary file.

## 📦 Installation (using lazy.nvim)

```lua
{
  dir = "~/path/to/nvim-dictionary", -- update this to your actual path
  name = "dictionary",
  cmd = { "DownloadEnglishWords", "SyncEnglishWords" },
  config = function()
    require("dictionary")
  end,
}


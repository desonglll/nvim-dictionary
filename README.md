
# nvim-dictionary

A simple Neovim plugin to download and sync a local English dictionary file.

## 📦 Installation (using lazy.nvim)

```lua
{
    "desonglll/nvim-dictionary,"
    name = "dictionary",
    cmd = { "DownloadEnglishWords", "SyncEnglishWords" },
    config = function()
        require("dictionary")
    end,
}


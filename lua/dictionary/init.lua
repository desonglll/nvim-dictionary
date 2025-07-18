-- lua/dictionary/init.lua
local M = {}
local downloader = require("dictionary.downloader")

local did_setup = false

function M.setup(opts)
    opts = opts or {}
    downloader.setup(opts)

    if did_setup then return end
    did_setup = true

    vim.api.nvim_create_user_command("DownloadEnglishWords", function()
        downloader.download()
    end, {
        desc = "Download English words dictionary (if not exists)",
    })

    vim.api.nvim_create_user_command("SyncEnglishWords", function()
        downloader.sync()
    end, {
        desc = "Force download (sync) English words dictionary",
    })

    vim.api.nvim_create_user_command("DictionaryDir", function()
        print(downloader.get_words_dir())
    end, {
        desc = "Get words directory",
    })
end

return M

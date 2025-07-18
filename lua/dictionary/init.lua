-- lua/dictionary/init.lua
local downloader = require("dictionary.downloader")

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

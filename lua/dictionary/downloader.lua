-- lua/dictionary/downloader.lua
local M = {}

local words_url = "https://raw.githubusercontent.com/dwyl/english-words/refs/heads/master/words.txt"
local words_file = vim.fs.joinpath(vim.fn.stdpath("config"), "dictionary", "words.txt")

local function file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file"
end

function M.download()
    if file_exists(words_file) then
        print("✔️ English words already exist: " .. words_file)
        return
    end
    M._download_file()
end

function M.sync()
    if file_exists(words_file) then
        print("Removing existing file: " .. words_file)
        vim.fs.rm(words_file)
    end
    M._download_file()
end

function M._download_file()
    local cmd = { "curl", "-fLo", words_file, "--create-dirs", words_url }
    print("Downloading: " .. words_url)
    local result = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
        print("✅ Download succeeded → " .. words_file)
    else
        print("❌ Download failed:\n" .. result)
    end
end

return M

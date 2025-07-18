-- lua/dictionary/downloader.lua
local M = {}

local words_url = "https://raw.githubusercontent.com/dwyl/english-words/refs/heads/master/words.txt"
local words_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "dictionary")
local words_file = vim.fs.joinpath(words_dir, "words.txt")

local function file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file"
end

function M.setup(opts)
    opts = opts or {}

    local has_dir = type(opts.dir) == "string" and opts.dir ~= ""
    local has_file = type(opts.file) == "string" and opts.file ~= ""

    if has_dir and has_file then
        words_dir = opts.dir
        words_file = vim.fs.joinpath(words_dir, opts.file)
    elseif has_file then
        words_file = opts.file
        words_dir = vim.fs.dirname(words_file)
    elseif has_dir then
        words_dir = opts.dir
        words_file = vim.fs.joinpath(words_dir, "words.txt")
    else
        words_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "dictionary")
        words_file = vim.fs.joinpath(words_dir, "words.txt")
    end

    print("📁 Dictionary dir:  " .. words_dir)
    print("📄 Dictionary file: " .. words_file)
end

function M.get_words_dir()
    return words_dir
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

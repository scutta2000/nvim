local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Relative line numbers
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.scrolloff = 10 --Always keep at least n line above and below cursor
opt.timeoutlen = 300 --Time in ms to wait for a mapped sequence to complete
opt.expandtab = true --Spaces instead of tabs
opt.shiftwidth = 2 --Number of spaces in indentation
-- Code folding
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true
--

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

opt.path:remove "/usr/include"
opt.path:append "**"
opt.wildignorecase = true

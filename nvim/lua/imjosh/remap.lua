local M = require("imjosh.keymap")
local nnoremap = M.nnoremap
local inoremap = M.inoremap
local vnoremap = M.vnoremap

-- Toggle spell check
nnoremap("<leader>ss", ":set spell!<CR>", {silent = true})

-- Center screen on <Ctrl-[ud]>
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- Clear search results
nnoremap("<leader>sc", ":noh<CR>")

-- Open terminal
nnoremap("<leader>t", ":terminal<CR>")

-- Telescope
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")
nnoremap("<leader>fd", ":Telescope coc workspace_diagnostics<CR>")

-- Open new tab
nnoremap("<leader><C-t>", ":tabnew<CR>")

-- Git
nnoremap("<leader>G", ":Neotree float git_status<CR>")

-- Misc helpers
nnoremap("<leader>p", "\"0p<CR>")
nnoremap("<leader>ra", ":%s/")

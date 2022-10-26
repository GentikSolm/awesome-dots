local M = require("imjosh.keymap")
local nnoremap = M.nnoremap
local inoremap = M.inoremap
local vnoremap = M.vnoremap

nnoremap("<leader>ss", ":set spell!<CR>", {silent = true})
nnoremap("<leader>sc", ":noh<CR>")
nnoremap("<leader>t", ":terminal<CR>")

-- Telescope
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")

nnoremap("<leader><C-t>", ":tabnew<CR>")
nnoremap("<leader>gu", ":CocCommand git.chunkUndo<CR>")
nnoremap("<leader>gi", ":CocCommand git.chunkInfo<CR>")
nnoremap("<leader>G", ":Neotree float git_status<CR>")
nnoremap("<leader>p", "\"0p<CR>")
nnoremap("<leader>ra", ":%s/")

-- Hop
nnoremap("<leader>hw", ":HopWord<CR>")
nnoremap("<leader>hl", ":HopLineStart<CR>")
nnoremap("<leader>hp", ":HopPattern<CR>")
nnoremap("<leader>hf", ":HopWordCurrentLine<CR>")
nnoremap("<leader>ha", ":HopAnywhereCurrentLine<CR>")
nnoremap("<leader>hW", ":HopWordMW<CR>")
vnoremap("<leader>hw", "<cmd>HopWord<CR>")
vnoremap("<leader>hl", "<cmd>HopLineStart<CR>")
vnoremap("<leader>hp", "<cmd>HopPattern<CR>")
vnoremap("<leader>hf", "<cmd>HopWordCurrentLine<CR>")
vnoremap("<leader>ha", "<cmd>HopAnywhereCurrentLine<CR>")
vnoremap("<leader>hW", "<cmd>HopWordMW<CR>")

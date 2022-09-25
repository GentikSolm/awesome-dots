local M = require("imjosh.keymap")
local nnoremap = M.nnoremap
local inoremap = M.inoremap

nnoremap("<leader>ss", ":set spell!<CR>", {silent = true})
nnoremap("<leader>sc", ":noh<CR>")
nnoremap("<leader>t", ":terminal<CR>")
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")
nnoremap("<leader>fb", ":Telescope buffers<CR>")
nnoremap("<leader>fh", ":Telescope help_tags<CR>")
nnoremap("<leader><C-t>", ":tabnew<CR>")
nnoremap("<leader>gu", ":CocCommand git.chunkUndo<CR>")
nnoremap("<leader>gi", ":CocCommand git.chunkInfo<CR>")
nnoremap("<leader>G", ":Neotree float git_status<CR>")
nnoremap("<leader>p", "\"0p<CR>")
nnoremap("<leader>ra", ":%s/")


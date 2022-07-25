local M = require("imjosh.keymap")
local nnoremap = M.nnoremap
local inoremap = M.inoremap

nnoremap("<leader>d", "<cmd>Ex<CR>")
nnoremap("<leader>s", ":set spell!<CR>", {silent = true})
nnoremap("<leader>c", ":noh<CR>")
nnoremap("<leader>t", ":terminal<CR>")
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")
nnoremap("<leader>fb", ":Telescope buffers<CR>")
nnoremap("<leader>fh", ":Telescope help_tags<CR>")
nnoremap("<leader><C-t>", ":tabnew<CR>")


require('imjosh.set')
require('imjosh.remap')
require('imjosh.plugins')
require('imjosh.plugconf')
require("nvim-python-repl").setup()
require("tokyonight").setup({
    transparent = true,
    styles = {
        sidebars = "transparent"
    }
})
vim.cmd('source ~/.config/nvim/lua/imjosh/coc.vim') 


vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {"BurntSushi/ripgrep"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    use "HerringtonDarkholme/yats.vim"

    use "maxmellon/vim-jsx-pretty"
end)

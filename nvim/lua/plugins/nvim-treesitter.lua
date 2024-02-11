return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  config = function()
    local configs = require('nvim-treesitter.configs')
    configs.setup({
      autotag = {
        enable = true,
      },
      highlight = {
        enable = true
      },
    })
  end
}

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "tsx", "lua", "typescript" },
      highlight = {
        enable = true,
      },
    })
    require("nvim-ts-autotag").setup()
  end,
}

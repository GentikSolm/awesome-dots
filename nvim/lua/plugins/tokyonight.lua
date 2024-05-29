return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,     -- Enable this to disable setting the background color
      styles = {
        sidebars = "transparent", -- style for sidebars, see below
      },
    })
  end,
}

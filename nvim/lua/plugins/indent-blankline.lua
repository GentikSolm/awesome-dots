return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup({
      debounce = 50,
      scope = {
        show_start = false,
        show_end = false
      }
    })
  end,
}

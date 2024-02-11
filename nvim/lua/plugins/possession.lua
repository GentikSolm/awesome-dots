return {
  "jedrzejboczar/possession.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function()
    require('possession').setup({
      autosave = {
        tmp = true,
        current = true,
        on_quit = true,
      }
    })
  end
}

return {
  "goolord/alpha-nvim",
  dependencies = { 'jedrzejboczar/possession.nvim' },
  config = function()
    local dashboard = require('alpha.themes.dashboard')
    -- Footer
    local function footer()
      local version = vim.version()
      local print_version = "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch
      local datetime = os.date('%Y/%m/%d %H:%M:%S')

      return print_version .. ' - ' .. datetime
    end

    -- Banner
    local banner = {
      "                                                    ",
      " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                    ",
    }

    dashboard.section.header.val = banner

    -- Menu
    dashboard.section.buttons.val = {
      dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
      dashboard.button('g', '  Grep word', ':Telescope live_grep<CR>'),
      dashboard.button('l', "⟳  Load Workspace", ":PossessionLoad tmp<CR>"),
      dashboard.button('s', '  Settings', ':e $MYVIMRC<CR>'),
      dashboard.button('u', '  Update plugins',
        function()
          vim.cmd(":TSUpdate")
          vim.cmd(":MasonUpdate")
          vim.cmd(":Lazy update")
        end),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = footer()
    require("alpha").setup(dashboard.config)
  end,
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local ensure_installed = {
      "lua_ls",
      "astro",
      "bashls",
      "dockerls",
      "eslint",
      "gopls",
      "marksman",
      "pyright",
      "tailwindcss",
      "yamlls",
    }
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })
  end,
}

-- Aliases
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local api = vim.api

function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

local autocmds = {
    terminal_job = {
        { "TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]] };
        { "TermOpen", "*", "startinsert" };
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" };
    };
    packer = {
        { "BufWritePost", "plugins.lua", "PackerCompile" };
    };
    project_drawer = {
        {"VimEnter", "*", ":Neotree show"}
    };
}

g.mapleader = ","

-- coc Config
opt.signcolumn = "number"
opt.updatetime = 300
opt.cmdheight = 2

-- Git config
vim.cmd("set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}\\ \\|\\ %F")

-- base nvim config
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.number = true                   -- Show line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 4                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.softtabstop = 4                 -- Soft tab stop
opt.shiftwidth = 4
opt.incsearch = true
opt.relativenumber = true           -- relative line numbers
opt.termguicolors = true            -- True color support
g.wildmenu = false

opt.wrap = false                    -- Disable line wrap
opt.mouse = "a"                     -- make mouse usable
opt.laststatus = 2                  -- keep buffer open
opt.shell = 'zsh'                   -- use zsh shell
opt.spelllang = "en"                -- language for spell checker
opt.spellsuggest = "best, 9"

nvim_create_augroups(autocmds)

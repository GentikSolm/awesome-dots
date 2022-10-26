# Neovim dotfiles

Blazingly fast neovim config. I try to be slightly minimal yet highly functional

### Dependencies

* `Packer` as a package manager
* `CoC` as lsp manager
* `ripgrep` for telescope ripgrep pane

### Featuring

* Telescope for jumping between files
* Hop for jumping around buffers
* Tokyonight as a theme
* Wilder as menu
* neo-tree as filetree


### Installation

First, make sure `packer` is installed,
Next clone the contents of this folder to `~/.config/nvim/`,
Then run `:PackerSync` to install all plugins, and then install any desired `CoC` extensions.  
Make sure you go replace my hard coded venv path in `CocConfig`!

### Custom Keybinds

Keybinds can be found in `remap.lua` and general settings in `set.lua`.  
Here is an overview of the custom keybinds:

```lua
-- Toggle spell check
nnoremap("<leader>ss", ":set spell!<CR>", {silent = true})

-- Clear search results
nnoremap("<leader>sc", ":noh<CR>")

-- Open terminal
nnoremap("<leader>t", ":terminal<CR>")

-- Telescope
nnoremap("<leader>ff", ":Telescope find_files<CR>")
nnoremap("<leader>fg", ":Telescope live_grep<CR>")

-- Open new tab
nnoremap("<leader><C-t>", ":tabnew<CR>")

-- Git commands
nnoremap("<leader>gu", ":CocCommand git.chunkUndo<CR>")
nnoremap("<leader>gi", ":CocCommand git.chunkInfo<CR>")
nnoremap("<leader>G", ":Neotree float git_status<CR>")

-- Misc helpers
nnoremap("<leader>p", "\"0p<CR>")
nnoremap("<leader>ra", ":%s/")

-- Hop
nnoremap("<leader>hw", ":HopWord<CR>")
nnoremap("<leader>hl", ":HopLineStart<CR>")
nnoremap("<leader>hp", ":HopPattern<CR>")
nnoremap("<leader>hf", ":HopWordCurrentLine<CR>")
nnoremap("<leader>ha", ":HopAnywhereCurrentLine<CR>")
nnoremap("<leader>hW", ":HopWordMW<CR>")
vnoremap("<leader>hw", "<cmd>HopWord<CR>")
vnoremap("<leader>hl", "<cmd>HopLineStart<CR>")
vnoremap("<leader>hp", "<cmd>HopPattern<CR>")
vnoremap("<leader>hf", "<cmd>HopWordCurrentLine<CR>")
vnoremap("<leader>ha", "<cmd>HopAnywhereCurrentLine<CR>")
vnoremap("<leader>hW", "<cmd>HopWordMW<CR>")
```

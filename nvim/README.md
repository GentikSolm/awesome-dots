# Neovim dotfiles

Blazingly fast neovim config. I try to be slightly minimal yet highly functional

### Dependencies

* `Packer` as a package manager
* `CoC` as lsp manager
* `ripgrep` for telescope ripgrep pane

### Featuring

* Telescope for jumping between files
* Tokyonight as a theme
* neo-tree as filetree


### Installation

First, make sure `packer` is installed,
Next clone the contents of this folder to `~/.config/nvim/`,
Then run `:PackerSync` to install all plugins, and then install any desired `CoC` extensions.  
Make sure you go replace my hard coded venv path in `CocConfig`!

### Custom Keybinds

Keybinds can be found in `remap.lua` and general settings in `set.lua`.  

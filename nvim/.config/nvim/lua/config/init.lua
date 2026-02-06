-- Load all configuration modules

require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Git root detection for LSP workspace and Neo-tree
-- Options: update_cwd (false), update_lsp (true), update_neotree (true)
require('config.git_root').setup({
  update_cwd = false, -- Set to true to also change Neovim's cwd
  update_lsp = true,
  update_neotree = true,
})

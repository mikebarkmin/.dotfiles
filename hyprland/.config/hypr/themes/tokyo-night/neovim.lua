-- Adapted from omarchy themes/tokyo-night/neovim.lua.
-- Omarchy drives the colorscheme via LazyVim/LazyVim opts; this config is plain
-- lazy.nvim, so it is applied in `config` and recorded in vim.g.theme_* so
-- lua/plugins/theme.lua can re-assert it on VimEnter.
return {
  {
    'folke/tokyonight.nvim',
    opts = {
      style = 'night',
    },
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.g.theme_colorscheme = 'tokyonight-night'
      vim.g.theme_background = 'dark'
      vim.o.background = 'dark'
      vim.cmd.colorscheme('tokyonight-night')
    end,
  },
}

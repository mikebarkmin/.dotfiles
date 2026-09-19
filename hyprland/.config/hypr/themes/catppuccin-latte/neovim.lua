-- Adapted from omarchy themes/catppuccin-latte/neovim.lua.
-- Omarchy drives the colorscheme via LazyVim/LazyVim opts; this config is plain
-- lazy.nvim, so it is applied in `config` and recorded in vim.g.theme_* so
-- lua/plugins/theme.lua can re-assert it on VimEnter.
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'latte',
    },
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.g.theme_colorscheme = 'catppuccin-latte'
      vim.g.theme_background = 'light'
      vim.o.background = 'light'
      vim.cmd.colorscheme('catppuccin-latte')
    end,
  },
}

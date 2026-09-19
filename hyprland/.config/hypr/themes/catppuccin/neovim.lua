-- Adapted from omarchy themes/catppuccin/neovim.lua.
-- Omarchy drives the colorscheme via LazyVim/LazyVim opts; this config is plain
-- lazy.nvim, so it is applied in `config` and recorded in vim.g.theme_* so
-- lua/plugins/theme.lua can re-assert it on VimEnter.
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'mocha',
    },
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.g.theme_colorscheme = 'catppuccin-mocha'
      vim.g.theme_background = 'dark'
      vim.o.background = 'dark'
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },
}

-- Adapted from omarchy themes/hackerman/neovim.lua.
-- Omarchy drives the colorscheme via LazyVim/LazyVim opts; this config is plain
-- lazy.nvim, so it is applied in `config` and recorded in vim.g.theme_* so
-- lua/plugins/theme.lua can re-assert it on VimEnter.
return {
  {
    'bjarneo/hackerman.nvim',
    dependencies = { 'bjarneo/aether.nvim' }, -- Ensure aether is loaded first
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      -- hackerman.nvim ships only colors/, there is no setup() to call
      vim.g.theme_colorscheme = 'hackerman'
      vim.g.theme_background = 'dark'
      vim.o.background = 'dark'
      vim.cmd.colorscheme('hackerman')
    end,
  },
}

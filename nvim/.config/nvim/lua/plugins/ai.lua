-- AI coding assistants

return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
  },

  -- CodeCompanion AI chat
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      opts = {
        log_level = 'DEBUG',
      },
    },
    keys = {
      { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion Actions' },
      { '<LocalLeader>a', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'Toggle CodeCompanion Chat' },
      { 'ga', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add to CodeCompanion Chat' },
    },
    config = function(_, opts)
      require('codecompanion').setup(opts)
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}

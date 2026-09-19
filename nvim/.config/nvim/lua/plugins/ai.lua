-- AI assistant
--
-- Mistral Vibe runs as an external agent over ACP (`vibe-acp` on PATH, which
-- inherits MISTRAL_API_KEY from the environment). ACP adapters are chat-only in
-- CodeCompanion, so the inline and cmd interactions are left unconfigured
-- rather than pointed at a second, HTTP-based backend.

return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = {
      'CodeCompanion',
      'CodeCompanionActions',
      'CodeCompanionChat',
      'CodeCompanionCmd',
    },
    keys = {
      { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'AI action palette' },
      { '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'AI chat toggle' },
      { '<leader>ad', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'AI add selection to chat' },
    },
    opts = {
      interactions = {
        chat = { adapter = 'mistral_vibe' },
      },
    },
  },
  -- Renders the chat buffer. Uses the markdown parsers bundled with Neovim,
  -- so this needs no nvim-treesitter install.
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
    opts = {
      file_types = { 'markdown', 'codecompanion' },
    },
  },
}

-- AI coding assistants

return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
  },
  -- Snacks.nvim for better input UI (required for concealed input in avante)
  {
    'folke/snacks.nvim',
    event = 'VeryLazy',
  },
  -- Avante.nvim - AI coding assistant with ACP support
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = vim.fn.has('win32') ~= 0
        and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
        or 'make',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      provider = 'mistral',
      input = {
        provider = 'snacks',
      },
      providers = {
        mistral = {
          endpoint = 'https://api.mistral.ai/v1',
          model = 'mistral-large-latest',
          api_key = os.getenv('MISTRAL_API_KEY'),
        },
      },
      behaviour = {
        auto_approve_tool_permissions = true,
      },
      acp_providers = {
        ['mistral-vibe'] = {
          command = 'vibe-acp',
          env = {
            MISTRAL_API_KEY = os.getenv('MISTRAL_API_KEY'),
          },
        },
      },
    },
  },
}

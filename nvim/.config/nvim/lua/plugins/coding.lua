-- Coding assistance plugins

return {
  -- Guess indent settings
  {
    'nmac427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {}
    end,
  },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Indent line indicators
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = {
        enabled = true,
        char = '▎',
        include = {
          node_type = { lua = { 'return_statement', 'table_constructor' } },
        },
      },
      indent = {
        char = '▏',
      },
    },
  },
}

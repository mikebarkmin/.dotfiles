-- Language-specific plugins

return {
  -- Java development (JDTLS)
  {
    'mfussenegger/nvim-jdtls',
    -- Configured in ftplugin/java.lua
  },

  -- Otter for embedded LSP in markdown code blocks
  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
  },
}

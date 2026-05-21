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
    opts = {},
  },
  {
    "salkin-mada/openscad.nvim",
    config = function()
      vim.g.openscad_load_snippets = true
      require("openscad")

      vim.g.openscad_cheatsheet_toggle_key = '<Enter>'
      vim.g.openscad_help_trig_key = '<leader>ah'
      vim.g.openscad_manual_trig_key = '<leader>am'
      vim.g.openscad_exec_openscad_trig_key = '<leader>ao'
      vim.g.openscad_top_toggle = '<leader>ac'
    end,
    dependencies = { "L3MON4D3/LuaSnip", "junegunn/fzf.vim" },
  },
}

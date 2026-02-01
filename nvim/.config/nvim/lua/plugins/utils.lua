-- Utility plugins and custom configurations

-- Helper function for opening binary files
local function xdg_open()
  local prev_buf = vim.fn.bufnr('%')
  local fn = vim.fn.expand('%:p')
  vim.fn.jobstart('xdg-open "' .. fn .. '"')
  vim.api.nvim_echo({ { string.format('Opening file: %s', fn), 'None' } }, false, {})
  if vim.fn.buflisted(prev_buf) == 1 then
    vim.api.nvim_set_current_buf(prev_buf)
  end
  vim.api.nvim_buf_delete(0, { force = true })
end

-- Open binary files with the default application
local bin_files = vim.api.nvim_create_augroup('binFiles', { clear = true })
local file_types = {
  'pdf',
  'jpg',
  'jpeg',
  'webp',
  'png',
  'mp3',
  'mp4',
  'xls',
  'xlsx',
  'xopp',
  'gif',
  'doc',
  'docx',
}

for _, ext in ipairs(file_types) do
  vim.api.nvim_create_autocmd({ 'BufReadCmd' }, {
    pattern = '*.' .. ext,
    group = bin_files,
    callback = xdg_open,
  })
end

return {
  -- Sudo write support
  {
    'lambdalisue/vim-suda',
    config = function()
      vim.cmd([[ let g:suda#noninteractive = 1 ]])
    end,
  },

  -- Session management
  {
    'tpope/vim-obsession',
  },

  -- Kitty terminal navigation
  {
    'MunsMan/kitty-navigator.nvim',
    build = {
      'cp navigate_kitty.py ~/.config/kitty',
      'cp pass_keys.py ~/.config/kitty',
    },
    opts = { keybindings = {} },
  },

  -- Automatic light/dark theme switching
  {
    'vimpostor/vim-lumen',
  },

  -- Smart text wrapping for prose
  {
    'andrewferrier/wrapping.nvim',
    config = function()
      require('wrapping').setup {
        auto_set_mode_filetype_allowlist = {
          'asciidoc',
          'gitcommit',
          'latex',
          'mail',
          'markdown',
          'org',
          'rst',
          'tex',
          'text',
        },
      }
    end,
  },

  -- Performance for large files
  {
    'LunarVim/bigfile.nvim',
  },
}

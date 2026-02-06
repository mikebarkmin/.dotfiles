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

  -- Hyperbook development helper
  {
    'folke/which-key.nvim',
    optional = true,
    opts = function(_, opts)
      -- Check if .hyperbook or .hyperlibrary exists in root
      local function is_hyperbook_project()
        local root = vim.fn.getcwd()
        return vim.fn.filereadable(root .. '/.hyperbook') == 1
          or vim.fn.filereadable(root .. '/.hyperlibrary') == 1
      end

      local hyperbook_job_id = nil
      local hyperbook_port = 8080

      local function start_hyperbook_dev()
        if not is_hyperbook_project() then
          vim.notify('Not a Hyperbook project (.hyperbook or .hyperlibrary not found)', vim.log.levels.WARN)
          return
        end
        if hyperbook_job_id then
          vim.notify('Hyperbook dev server already running', vim.log.levels.INFO)
          return
        end
        hyperbook_job_id = vim.fn.jobstart('npx hyperbook dev', {
          on_exit = function()
            hyperbook_job_id = nil
          end,
        })
        vim.notify('Hyperbook dev server started on port ' .. hyperbook_port, vim.log.levels.INFO)
      end

      local function stop_hyperbook_dev()
        if hyperbook_job_id then
          vim.fn.jobstop(hyperbook_job_id)
          hyperbook_job_id = nil
          vim.notify('Hyperbook dev server stopped', vim.log.levels.INFO)
        else
          vim.notify('No Hyperbook dev server running', vim.log.levels.WARN)
        end
      end

      local function open_hyperbook_browser()
        if not is_hyperbook_project() then
          vim.notify('Not a Hyperbook project (.hyperbook or .hyperlibrary not found)', vim.log.levels.WARN)
          return
        end
        local url = 'http://localhost:' .. hyperbook_port
        vim.fn.jobstart('xdg-open "' .. url .. '"')
        vim.notify('Opening ' .. url, vim.log.levels.INFO)
      end

      local function set_hyperbook_port()
        vim.ui.input({ prompt = 'Hyperbook port: ', default = tostring(hyperbook_port) }, function(input)
          if input then
            hyperbook_port = tonumber(input) or 8080
            vim.notify('Hyperbook port set to ' .. hyperbook_port, vim.log.levels.INFO)
          end
        end)
      end

      -- Register keymaps only if in a hyperbook project
      if is_hyperbook_project() then
        vim.keymap.set('n', '<leader>hd', start_hyperbook_dev, { desc = 'Start Hyperbook dev server' })
        vim.keymap.set('n', '<leader>hs', stop_hyperbook_dev, { desc = 'Stop Hyperbook dev server' })
        vim.keymap.set('n', '<leader>ho', open_hyperbook_browser, { desc = 'Open Hyperbook in browser' })
        vim.keymap.set('n', '<leader>hp', set_hyperbook_port, { desc = 'Set Hyperbook port' })
      end

      return opts
    end,
  },
}

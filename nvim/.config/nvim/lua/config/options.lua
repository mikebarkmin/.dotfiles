-- Neovim options
-- See `:help vim.opt` and `:help option-list`

local opt = vim.opt

-- Nerd Font check
vim.g.have_nerd_font = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Mouse
opt.mouse = 'a'

-- Mode display (hidden because shown in statusline)
opt.showmode = false

-- Clipboard (scheduled to avoid startup slowdown)
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Indentation
opt.breakindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

-- Undo
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'  -- Preview substitutions

-- UI
opt.signcolumn = 'yes'
opt.cursorline = true
opt.scrolloff = 10
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Timing
opt.updatetime = 250
opt.timeoutlen = 300

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Line wrap
vim.wo.wrap = false

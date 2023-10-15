local exec = vim.api.nvim_exec -- execute Vimscript
local set = vim.opt -- global options
local cmd = vim.cmd -- execute Vim commands
-- local fn    = vim.fn            -- call Vim functions
local g = vim.g -- global variables
-- local b     = vim.bo            -- buffer-scoped options
-- local w     = vim.wo            -- windows-scoped options


vim.cmd [[ set formatoptions=croq]]
vim.cmd [[ colorscheme catppuccin-frappe ]]
set.guifont = "FiraCode Nerd Font 11"
set.termguicolors = true -- Enable GUI colors for the terminal to get truecolor
set.undofile = true
set.undodir = vim.fn.stdpath("config") .. "/undo"
set.clipboard = set.clipboard + "unnamedplus" -- copy & paste
set.wrap = false -- don't automatically wrap on load
set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line
set.number = true -- show line numbers
set.relativenumber = true -- show relative line number
set.incsearch = true -- incremental search
set.hlsearch = true -- highlighted search results
set.ignorecase = true -- ignore case sensetive while searching
set.smartcase = true
set.scrolloff = 1 -- when scrolling, keep cursor 1 lines away from screen border
set.sidescrolloff = 2 -- keep 30 columns visible left and right of the cursor at all times
set.backspace = "indent,start,eol" -- make backspace behave like normal again
set.mouse = "a" -- turn on mouse interaction
set.updatetime = 500 -- CursorHold interval
set.expandtab = true
set.softtabstop = 2
-- set.textwidth = 100
set.shiftwidth = 2 -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
set.tabstop = 2 -- spaces per tab
set.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
set.autoindent = true -- maintain indent of current line
set.shiftround = true
set.splitbelow = true -- open horizontal splits below current window
set.splitright = true -- open vertical splits to the right of the current window
set.laststatus = 2 -- always show status line
-- set.colorcolumn = "79"        -- vertical word limit line

set.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
set.inccommand = "split" -- live preview of :s results
set.shell = "zsh" -- shell to use for `!`, `:!`, `system()` etc.
-- highlight on yank
exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
  augroup end
]],
  false
)

-- jump to the last position when reopening a file
cmd(
  [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]]
)

-- auto source vim
cmd([[
  augroup neovim
		autocmd!
		autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
	augroup end
]])

-- patterns to ignore during file-navigation
set.wildignore = set.wildignore + "*.o,*.rej,*.so"
-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])
-- faster scrolling
set.lazyredraw = true
-- completion options
set.completeopt = "menuone,noselect,noinsert"

cmd([[ autocmd BufNewFile,BufRead *.mdx set filetype=markdown ]])

-- 2 spaces for selected filetypes
cmd([[ autocmd FileType xml,html,xhtml,css,scssjavascript,lua,dart setlocal shiftwidth=2 tabstop=2 ]])
-- json
cmd([[ au BufEnter *.json set ai expandtab shiftwidth=2 tabstop=2 sta fo=croql ]])

--- latex
g.tex_flavor = "latex"
cmd([[ autocmd FileType latex,tex,plaintex set wrap linebreak ]])

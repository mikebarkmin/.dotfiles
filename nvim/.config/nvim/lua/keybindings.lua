local map = require("utils").map

vim.g.mapleader = " "

-- wrap
map("n", "<Leader>w", ":set wrap! linebreak!<cr>")
map("n", "j", "gj")
map("n", "k", "gk")

-- navigation
--- behave like other capitals
map("n", "Y", "y$")
--- keeping it centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")
--- moving text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>k", ":m .-2<CR>==")
map("n", "<leader>j", ":m .+1<CR>==")

-- telescope
map("n", "<Leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<Leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<Leader>fr", "<cmd>Telescope bibtex<cr>")

--- quicklist
map("n", "<leader>qn", "<cmd>:cnext<cr>")
map("n", "<leader>qp", "<cmd>:cprev<cr>")
map("n", "<leader>qo", "<cmd>:copen<cr>")

-- lua tree
map("n", "<Leader>tt", "<cmd>NvimTreeToggle<cr>")
map("n", "<Leader>tf", "<cmd>NvimTreeFindFileToggle<cr>")
map("n", "<Leader>tr", "<cmd>NvimTreeRefresh<cr>")

-- language server
map("n", "<Leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "<Leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<Leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<Leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<Leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<Leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<Leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<Leader>vsd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
map("n", "<Leader>vn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", "<Leader>vp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "<Leader>vf", "<cmd>Format<CR>")

-- neogit
map("n", "<Leader>go", "<cmd>Neogit<CR>")
map("n", "<Leader>gc", "<cmd>Neogit commit<CR>")
map("n", "<Leader>gws", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>")
map("n", "<Leader>gwc", "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>")

--- zen-mode
map("n", "<leader>z", "<cmd>ZenMode<cr>")

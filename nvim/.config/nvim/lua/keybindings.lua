local map = require("utils").map

vim.g.mapleader = " "
map("n", "<Leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<Leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<Leader>ft", "<cmd>Telescope file_browser<cr>")

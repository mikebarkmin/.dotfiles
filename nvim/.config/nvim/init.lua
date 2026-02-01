-- Neovim configuration entry point
-- See lua/config/ for core settings and lua/plugins/ for plugin specs

-- Set leader keys before loading anything
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim and load plugins
require('config.lazy')

-- Load core configuration
require('config')

-- vim: ts=2 sts=2 sw=2 et

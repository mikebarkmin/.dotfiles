-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup {
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use {
      "neovim/nvim-lspconfig",
      wants = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim"
      },
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim"
      },
      config = [[ require('plugins/lsp') ]]
    }

    use {
      -- vscode-like pictograms for neovim lsp completion items Topics
      "onsails/lspkind-nvim",
      config = [[ require('plugins/lspkind') ]]
    }
    --

    --[=[
    use {
      -- Utility functions for getting diagnostic status and progress messages from LSP servers, for use in the Neovim statusline
      "nvim-lua/lsp-status.nvim",
      config = [[ require('plugins/lspstatus') ]]
    }
    ]=]

    use {
      -- A completion plugin for neovim coded in Lua.
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim builtin LSP client
        "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for nvim lua
        "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
        "hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
        "hrsh7th/cmp-calc", -- nvim-cmp source for math calculation.
        "saadparwaiz1/cmp_luasnip" -- luasnip completion source for nvim-cmp
      },
      config = [[ require('plugins/cmp') ]]
    }

    use {
      "cohama/lexima.vim"
    }

    use {
      "nvim-telescope/telescope-project.nvim"
    }

    use {
      "nvim-telescope/telescope-dap.nvim",
      requires = {
        "mfussenegger/nvim-dap"
      }
    }

    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make"
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep"
      },
      config = [[ require('plugins/telescope') ]]
    }

    use {
      "nvim-telescope/telescope-bibtex.nvim",
      requires = {
        {"nvim-telescope/telescope.nvim"}
      },
      config = function()
        require "telescope".load_extension("bibtex")
      end
    }

    use {
      -- Snippet Engine for Neovim written in Lua.
      "L3MON4D3/LuaSnip",
      requires = {
        "rafamadriz/friendly-snippets" -- Snippets collection for a set of different programming languages for faster development.
      },
      config = [[ require('plugins/luasnip') ]]
    }

    use {
      --  colorscheme for (neo)vim
      "folke/tokyonight.nvim"
    }

    use {
      "vimpostor/vim-lumen"
    }

    use {
      -- Nvim Treesitter configurations and abstraction layer
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      requires = {
        "windwp/nvim-ts-autotag",
        "p00f/nvim-ts-rainbow"
      },
      config = [[ require('plugins/treesitter') ]]
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = [[ require('plugins/blankline') ]]
    }

    use {
      "tpope/vim-eunuch"
    }

    use {
      "nvim-lualine/lualine.nvim",
      requires = {"kyazdani42/nvim-web-devicons", opt = true},
      config = [[ require('plugins/lualine') ]]
    }

    use {
      "NeogitOrg/neogit",
      requires = {"nvim-lua/plenary.nvim"},
      config = [[ require('plugins/neogit') ]]
    }

    use {
      "nvim-tree/nvim-tree.lua",
      requires = "nvim-tree/nvim-web-devicons",
      config = [[ require('plugins/nvim-tree') ]]
    }

    use {
      "folke/zen-mode.nvim",
      config = [[ require('plugins/zen-mode') ]]
    }

    use {
      "ThePrimeagen/git-worktree.nvim",
      config = [[ require('plugins/git-worktree') ]]
    }

    use {
      "mhartington/formatter.nvim",
      config = [[ require('plugins/formatter') ]]
    }

    use {
      "kmonad/kmonad-vim"
    }

    use {
      "tpope/vim-obsession"
    }

    use {
      "lambdalisue/suda.vim"
    }

    if packer_bootstrap then
      require("packer").sync()
    end
  end
}

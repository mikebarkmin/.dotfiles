-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/var/home/mbarkmin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/var/home/mbarkmin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/var/home/mbarkmin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/var/home/mbarkmin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/var/home/mbarkmin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { " require('plugins/luasnip') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["formatter.nvim"] = {
    config = { " require('plugins/formatter') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/formatter.nvim",
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-worktree.nvim"] = {
    config = { " require('plugins/git-worktree') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/git-worktree.nvim",
    url = "https://github.com/ThePrimeagen/git-worktree.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { " require('plugins/blankline') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kmonad-vim"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/kmonad-vim",
    url = "https://github.com/kmonad/kmonad-vim"
  },
  ["lspkind-nvim"] = {
    config = { " require('plugins/lspkind') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { " require('plugins/lualine') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  neogit = {
    config = { " require('plugins/neogit') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nord.nvim",
    url = "https://github.com/shaunsingh/nord.nvim"
  },
  ["nvim-cmp"] = {
    config = { " require('plugins/cmp') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    config = { " require('plugins/lsp_installer_nvim') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { " require('plugins/lspconfig') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { " require('plugins/nvim-tree') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { " require('plugins/treesitter') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ripgrep = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/ripgrep",
    url = "https://github.com/BurntSushi/ripgrep"
  },
  ["telescope-bibtex.nvim"] = {
    config = { "\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\vbibtex\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/telescope-bibtex.nvim",
    url = "https://github.com/nvim-telescope/telescope-bibtex.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { " require('plugins/telescope') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-obsession"] = {
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/vim-obsession",
    url = "https://github.com/tpope/vim-obsession"
  },
  ["zen-mode.nvim"] = {
    config = { " require('plugins/zen-mode') " },
    loaded = true,
    path = "/var/home/mbarkmin/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
 require('plugins/nvim-tree') 
time([[Config for nvim-tree.lua]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
 require('plugins/formatter') 
time([[Config for formatter.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
 require('plugins/lspconfig') 
time([[Config for nvim-lspconfig]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
 require('plugins/luasnip') 
time([[Config for LuaSnip]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
 require('plugins/zen-mode') 
time([[Config for zen-mode.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
 require('plugins/cmp') 
time([[Config for nvim-cmp]], false)
-- Config for: telescope-bibtex.nvim
time([[Config for telescope-bibtex.nvim]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\vbibtex\19load_extension\14telescope\frequire\0", "config", "telescope-bibtex.nvim")
time([[Config for telescope-bibtex.nvim]], false)
-- Config for: nvim-lsp-installer
time([[Config for nvim-lsp-installer]], true)
 require('plugins/lsp_installer_nvim') 
time([[Config for nvim-lsp-installer]], false)
-- Config for: neogit
time([[Config for neogit]], true)
 require('plugins/neogit') 
time([[Config for neogit]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
 require('plugins/lualine') 
time([[Config for lualine.nvim]], false)
-- Config for: git-worktree.nvim
time([[Config for git-worktree.nvim]], true)
 require('plugins/git-worktree') 
time([[Config for git-worktree.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
 require('plugins/telescope') 
time([[Config for telescope.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
 require('plugins/treesitter') 
time([[Config for nvim-treesitter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
 require('plugins/blankline') 
time([[Config for indent-blankline.nvim]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
 require('plugins/lspkind') 
time([[Config for lspkind-nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

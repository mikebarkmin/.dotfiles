-- Colorscheme follows the desktop theme switcher.
-- ~/.config/hypr/active-theme-nvim.lua is a symlink maintained by
-- rofi-theme-switcher, pointing at the active theme's neovim.lua spec
-- (same layout as omarchy's themes/<name>/neovim.lua).
local themes_dir = vim.fn.expand('~/.config/hypr/themes')
local active = vim.fn.expand('~/.config/hypr/active-theme-nvim.lua')

-- Something during lazy's startup re-applies catppuccin's default flavour after
-- the plugin's own `config` has run, so re-assert the colorscheme once
-- everything is loaded. Specs record their choice in these globals.
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('ThemeSwitcher', { clear = true }),
  callback = function()
    local want = vim.g.theme_colorscheme
    if want and vim.g.colors_name ~= want then
      if vim.g.theme_background then
        vim.o.background = vim.g.theme_background
      end
      pcall(vim.cmd.colorscheme, want)
    end
  end,
})

local function load_spec(path)
  if not vim.uv.fs_stat(path) then
    return nil
  end
  local ok, spec = pcall(dofile, path)
  return ok and type(spec) == 'table' and spec or nil
end

local function plugin_id(p)
  return p.name or (type(p[1]) == 'string' and p[1]:match('([^/]+)$'))
end

local specs = load_spec(active) or {
  -- Fallback if no theme is active
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = { flavour = 'mocha' },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.g.theme_colorscheme = 'catppuccin-mocha'
      vim.g.theme_background = 'dark'
      vim.o.background = 'dark'
      vim.cmd.colorscheme('catppuccin-mocha')
    end,
  },
}

local seen = {}
for _, p in ipairs(specs) do
  seen[plugin_id(p)] = true
end

-- Declare the other themes' colorschemes too, installed but not loaded, so the
-- switcher can `lazy.load` them into a *running* nvim. Without this, lazy only
-- knows the active theme and live-switching across plugins fails.
local active_real = vim.uv.fs_realpath(active)
for name, kind in vim.fs.dir(themes_dir) do
  if kind == 'directory' then
    local path = themes_dir .. '/' .. name .. '/neovim.lua'
    if vim.uv.fs_realpath(path) ~= active_real then
      for _, p in ipairs(load_spec(path) or {}) do
        local id = plugin_id(p)
        if id and not seen[id] then
          seen[id] = true
          specs[#specs + 1] = {
            p[1],
            name = p.name,
            dependencies = p.dependencies,
            lazy = true,
          }
        end
      end
    end
  end
end

return specs

# My Neovim Configuration

A clean, modular Neovim configuration built on native LSP with manual LSP server installation.

## Structure

```
~/.config/nvim/
├── init.lua              # Minimal entry point (14 lines)
├── ftplugin/             # Filetype-specific configs (LSP startup)
└── lua/
    ├── config/           # Core Neovim configuration
    │   ├── options.lua   # vim.opt settings
    │   ├── keymaps.lua   # Global keymaps
    │   ├── autocmds.lua  # Autocommands
    │   └── lazy.lua      # Plugin manager setup
    └── plugins/          # Plugin specifications by category
        ├── ai.lua        # Copilot, CodeCompanion
        ├── coding.lua    # Autopairs, indentation
        ├── dap.lua       # Debugging
        ├── editor.lua    # Telescope, Treesitter, neo-tree
        ├── formatting.lua # conform.nvim
        ├── git.lua       # Gitsigns
        ├── lang.lua      # nvim-jdtls (Java)
        ├── lsp.lua       # LSP & completion
        ├── ui.lua        # Statusline, colorscheme
        └── utils.lua     # Utilities
```

## Features

- **Native LSP** - Pure `vim.lsp.start()` in ftplugin files (no mason, no lspconfig)
- **Telescope** - Fuzzy finder
- **Treesitter** - Syntax highlighting
- **blink.cmp** - Completion with LuaSnip
- **GitHub Copilot** & **CodeCompanion** - AI assistance
- **nvim-dap** - Debugging
- **catppuccin** - Colorscheme
- **lualine** - Statusline

## Installation

### Prerequisites

- Neovim >= 0.10.0
- Git, C compiler, ripgrep, make
- [Nerd Font](https://www.nerdfonts.com/) (recommended)

### Quick Install (Arch Linux)

For Arch Linux users, use the provided install script:

```bash
# Clone config
git clone <your-repo> ~/.config/nvim

# Run install script (installs all LSP servers and dependencies)
cd ~/.config/nvim
./install-arch.sh

# Start Neovim
nvim  # Lazy.nvim will install plugins
```

The install script will install:
- All LSP servers (Lua, Python, TypeScript, Go, LaTeX, etc.)
- Formatters (stylua, prettier, black, etc.)
- Debug adapters (delve for Go)
- System dependencies (ripgrep, fd, xclip, trash-cli)
- Optional: Java JDK and tools

### Manual Install

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup

# Clone and start
git clone <your-repo> ~/.config/nvim
nvim  # Lazy.nvim will install plugins
```

### Install LSP Servers

This config uses **manual LSP installation**:

```bash
# Lua
sudo pacman -S lua-language-server  # or: brew install lua-language-server

# Python
npm install -g pyright

# TypeScript/JavaScript
npm install -g typescript-language-server typescript

# Go
go install golang.org/x/tools/gopls@latest
```

See `ftplugin/{language}.lua` for required server commands.

## Key Bindings

Leader: `<Space>`

### General
- `<C-h/j/k/l>` - Navigate windows
- `<leader>q` - Diagnostics quickfix

### Telescope
- `<leader>sf` - Find files
- `<leader>sg` - Live grep
- `<leader>sb` - Buffers

### LSP
- `grd` - Go to definition
- `grr` - References
- `grn` - Rename
- `gra` - Code action
- `K` - Hover docs

### File Explorer
- `ää` - Toggle neo-tree

### AI
- `<C-a>` - CodeCompanion actions
- `<LocalLeader>a` - Toggle chat

### Debug
- `<F5>` - Start/Continue
- `<F1-3>` - Step into/over/out
- `<leader>b` - Toggle breakpoint

## Customization

### Add a Plugin

Edit `lua/plugins/{category}.lua`:
```lua
{
  'author/plugin-name',
  opts = {},
}
```

### Add LSP for New Language

Create `ftplugin/{filetype}.lua`:
```lua
local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

vim.lsp.start {
  name = 'your_lsp',
  cmd = { 'your-lsp-command' },
  root_dir = vim.fs.root(0, { '.git' }),
  capabilities = capabilities,
}
```

### Change Settings

Edit `lua/config/options.lua` and modify `vim.opt` settings.

## Troubleshooting

- **LSP not starting?** Check `which <server>`, `:LspInfo`, `:messages`
- **Plugin issues?** Run `:Lazy`, check `:messages`, try `:Lazy sync`
- **Health check:** `:checkhealth`

## Philosophy

1. **Native over plugins** - Use Neovim's built-in features
2. **Manual over automatic** - Explicit LSP installation
3. **Organized over monolithic** - Small, focused files
4. **Performance** - Lazy loading
5. **Maintainability** - Clear structure

Originally based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), heavily restructured.

## License

MIT

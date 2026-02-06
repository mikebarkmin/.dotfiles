-- Git root detection and workspace management
-- Provides automatic Git root detection for LSP workspace and Neo-tree

local M = {}

-- Cache for git roots (path -> git_root or false)
local git_root_cache = {}

---Find the nearest parent Git repository root for a buffer
---@param bufnr number|nil Buffer number (defaults to current buffer)
---@return string|nil Git root path or nil if not in a git repo
function M.find_git_root(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Get the file path for this buffer
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == '' then
    return nil
  end

  -- Get the directory containing the file
  local dir = vim.fn.fnamemodify(filepath, ':h')

  -- Check cache first
  if git_root_cache[dir] ~= nil then
    return git_root_cache[dir] or nil
  end

  -- Use vim.fs.find to locate .git (works for files and directories)
  local git_path = vim.fs.find('.git', {
    path = dir,
    upward = true,
    stop = vim.uv.os_homedir(),
    type = 'directory',
  })[1]

  -- Also check for .git file (submodules use this)
  if not git_path then
    git_path = vim.fs.find('.git', {
      path = dir,
      upward = true,
      stop = vim.uv.os_homedir(),
      type = 'file',
    })[1]
  end

  local root = git_path and vim.fn.fnamemodify(git_path, ':h') or nil

  -- Cache the result (false for no git repo to distinguish from uncached)
  git_root_cache[dir] = root or false

  return root
end

---Clear the git root cache (useful if repo structure changes)
function M.clear_cache()
  git_root_cache = {}
end

---Get git root for current buffer, with optional fallback to cwd
---@param fallback boolean|nil If true, returns cwd when no git root found
---@return string
function M.get_root_or_cwd(fallback)
  local root = M.find_git_root()
  if root then
    return root
  end
  return fallback and vim.fn.getcwd() or nil
end

---Update LSP workspace folders to use git root
---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
local function update_lsp_workspace(client, bufnr)
  local git_root = M.find_git_root(bufnr)
  if not git_root then
    return
  end

  -- Check if this root is already a workspace folder
  local workspace_folders = client.workspace_folders or {}
  for _, folder in ipairs(workspace_folders) do
    if folder.name == git_root then
      return -- Already configured
    end
  end

  -- Add the git root as workspace folder if client supports it
  if client.supports_method('workspace/didChangeWorkspaceFolders') then
    client.notify('workspace/didChangeWorkspaceFolders', {
      event = {
        added = { { uri = vim.uri_from_fname(git_root), name = git_root } },
        removed = {},
      },
    })
  end
end

---Set up autocommands for automatic git root detection
---@param opts table|nil Options table
---  - update_cwd: boolean - Also update Neovim's cwd (default: false)
---  - update_lsp: boolean - Update LSP workspace folders (default: true)
---  - update_neotree: boolean - Update Neo-tree root (default: true)
function M.setup(opts)
  opts = vim.tbl_extend('force', {
    update_cwd = false,
    update_lsp = true,
    update_neotree = true,
  }, opts or {})

  local augroup = vim.api.nvim_create_augroup('GitRootDetection', { clear = true })

  -- Update LSP workspace on attach
  if opts.update_lsp then
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      desc = 'Set LSP workspace to git root',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client then
          update_lsp_workspace(client, event.buf)
        end
      end,
    })
  end

  -- Update cwd and/or Neo-tree on BufEnter
  if opts.update_cwd or opts.update_neotree then
    vim.api.nvim_create_autocmd('BufEnter', {
      group = augroup,
      desc = 'Update root directory on buffer enter',
      callback = function(event)
        -- Skip special buffers
        local buftype = vim.bo[event.buf].buftype
        if buftype ~= '' then
          return
        end

        local git_root = M.find_git_root(event.buf)
        if not git_root then
          return
        end

        -- Update Neovim's cwd if enabled
        if opts.update_cwd then
          local current_cwd = vim.fn.getcwd()
          if current_cwd ~= git_root then
            vim.cmd.cd(git_root)
          end
        end
      end,
    })
  end
end

---Get the git root for Neo-tree to use
---This can be called from Neo-tree's config to set the root dynamically
---@return string
function M.neotree_root()
  return M.get_root_or_cwd(true)
end

---Reveal current file in Neo-tree at git root
---Opens Neo-tree with the git root as filesystem root
function M.neotree_reveal_at_root()
  local git_root = M.find_git_root()
  local filepath = vim.api.nvim_buf_get_name(0)

  if git_root and filepath ~= '' then
    vim.cmd(string.format('Neotree reveal dir=%s', vim.fn.fnameescape(git_root)))
  else
    vim.cmd('Neotree reveal')
  end
end

---Open Neo-tree at git root without revealing current file
function M.neotree_at_root()
  local git_root = M.find_git_root()
  if git_root then
    vim.cmd(string.format('Neotree dir=%s', vim.fn.fnameescape(git_root)))
  else
    vim.cmd('Neotree')
  end
end

return M

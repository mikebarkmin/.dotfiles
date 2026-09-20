local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

local typst_job
local typst_terminal

vim.keymap.set('n', '<leader>ao', function()
  -- Reuse the watcher instead of starting another one for the same buffer.
  if typst_job and vim.fn.jobwait({ typst_job }, 0)[1] == -1 then
    local windows = vim.fn.win_findbuf(typst_terminal)
    if windows[1] then
      vim.api.nvim_set_current_win(windows[1])
    else
      vim.cmd('botright 12split')
      vim.api.nvim_win_set_buf(0, typst_terminal)
    end
    return
  end

  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    vim.notify('Save the Typst file before launching the preview', vim.log.levels.WARN)
    return
  end

  vim.cmd.update()
  vim.cmd('botright 12new')
  typst_terminal = vim.api.nvim_get_current_buf()
  typst_job = vim.fn.jobstart({ 'typst', 'watch', file, '--open' }, { term = true })

  if typst_job <= 0 then
    vim.cmd.close()
    vim.notify('Could not start typst watch', vim.log.levels.ERROR)
    typst_job = nil
    typst_terminal = nil
    return
  end

  vim.cmd.startinsert()
end, { buffer = true, desc = 'Launch or focus Typst preview' })

vim.lsp.start {
  name = 'tinymist',
  cmd = { 'tinymist' },
  root_dir = vim.fs.root(0, { '.git' }) or vim.fn.getcwd(),
  capabilities = capabilities,
  settings = {
    formatterMode = 'typstyle',
  },
}

-- Wrap prose at 80 columns with gq.
-- tinymist advertises rangeFormatting, so nvim sets formatexpr to the LSP one
-- and gq gets routed to typstyle, which never reflows text. Clear it on attach
-- to get Vim's internal formatter back; vim.lsp.buf.format() still uses typstyle.
vim.opt_local.textwidth = 80
vim.api.nvim_create_autocmd('LspAttach', {
  buffer = 0,
  callback = function(args)
    if vim.lsp.get_client_by_id(args.data.client_id).name == 'tinymist' then
      -- deferred: nvim sets formatexpr after LspAttach fires
      vim.schedule(function()
        vim.bo[args.buf].formatexpr = ''
      end)
    end
  end,
})

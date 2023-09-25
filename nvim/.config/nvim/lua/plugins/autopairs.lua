require('nvim-autopairs').setup({
    enable_check_bracket_line = true, -- Don't add pairs if it already have a close pairs in same line
    disable_filetype = {"TelescopePrompt", "vim"}, --
    enable_afterquote = false, -- add bracket pairs after quote
    enable_moveright = true
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

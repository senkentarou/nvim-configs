--
-- Key mappings
--
-- wrap vim.keymap.set
-- see: https://neovim.io/doc/user/lua.html#vim.keymap.set()
local keymap = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- keymap with remap
local r = function(mode, lhs, rhs)
  keymap(mode, lhs, rhs, {
    remap = true,
  })
end

-- keymap with silent
local s = function(mode, lhs, rhs)
  keymap(mode, lhs, rhs, {
    silent = true,
  })
end

-- visual surround
for _, key in pairs({
  "{",
  "[",
  "(",
  "'",
  '"',
  "<",
}) do
  s('v', 's' .. key, function()
    require('visual-surround').surround(key)
  end)
end

-- command mode
r('c', '<C-a>', '<Home>')
r('c', '<C-e>', '<End>')
r('c', '<C-h>', '<Left>')
r('c', '<C-l>', '<Right>')
r('c', '<C-w>', '<S-Right>')
r('c', '<C-b>', '<S-Left>')

-- disable default keymap
r('n', '<C-z>', '<Nop>')
r('n', 'Z', '<Nop>')
r('n', 'Q', '<Nop>')
r('n', 'q', '<Nop>')
r('n', 'q:', '<Nop>')

-- moving window
s('n', '<C-j>', '<C-w><C-j>')
s('n', '<C-k>', '<C-w><C-k>')
s('n', '<C-l>', '<C-w><C-l>')
s('n', '<C-h>', '<C-w><C-h>')

-- moving cursor
r('n', 'j', '<Plug>(accelerated_jk_gj)')
r('n', 'k', '<Plug>(accelerated_jk_gk)')
r('n', 'w', '<Plug>(smartword-w)')
r('n', 'b', '<Plug>(smartword-b)')

-- hopping cursor
r('n', 's', '<Nop>')
s({ 'n', 'v' }, 'sj', '<Plug>(edgemotion-j)')
s({ 'n', 'v' }, 'sk', '<Plug>(edgemotion-k)')
s({ 'n', 'v' }, 'sh', '^')
s({ 'n', 'v' }, 'sl', '$')
s({ 'n', 'v' }, 'ss', '<CMD>lua require("hop").hint_patterns({}, vim.fn.input("[HopWithWord] "))<CR>')
s({ 'n', 'v' }, 'f', '<CMD>lua require("globals").hop_with_char({ direction = "after_cursor", current_line_only = true })<CR>')
s({ 'n', 'v' }, 'F', '<CMD>lua require("globals").hop_with_char({ direction = "before_cursor", current_line_only = true })<CR>')

-- leader family
vim.g.mapleader = " "
r('n', '<Space>', '<Nop>')
s('n', '<Leader><Space>', ':<C-u>lua require("globals").toggle_memo()<CR>')

s({ 'n', 'v' }, '<Leader>o', '<CMD>Gobf<CR>')
s({ 'n', 'v' }, '<Leader>O', '<CMD>Gobfop<CR>')
s('n', '<Leader>p', ':<C-u>Gocd<CR>')
s('n', '<Leader>P', ':<C-u>Gopr<CR>')

s('n', '<Leader>j', ':<C-u>lua vim.lsp.buf.definition()<CR>')
s('n', '<Leader>k', ':<C-u>lua vim.lsp.buf.references()<CR>')
s('n', '<Leader>h', ':<C-u>lua vim.lsp.buf.rename()<CR>')
s('n', '<Leader>l', ':<C-u>lua vim.lsp.buf.code_action()<CR>')
s('n', '<Leader>w', ':<C-u>w<CR>')
s('n', '<Leader>W', ':<C-u>lua vim.lsp.buf.format({ async = true })<CR>')
s('n', '=', ':<C-u>lua require("globals").toggle_lsp_lines_text()<CR>')

s('n', '<Leader>n', ':<C-u>lua require("telescope.builtin").grep_string({ search = vim.fn.histget("@", -1) })<CR>')
s('n', '<Leader>,', ':<C-u>lua require("telescope.builtin").grep_string({ search = require("globals").histadd_string(vim.fn.expand("<cword>")) })<CR>')
s('n', '<Leader>m', ':<C-u>lua require("telescope.builtin").grep_string({ search = require("globals").histadd_string(vim.fn.input("[GrepString] ")) })<CR>')

s('n', '<Leader>z', ':<C-u>ConfirmQuitAll<CR>')
s('n', '<Leader>q', ':<C-u>ConfirmQuit<CR>')

r('n', '<Leader>c', '<Plug>(comment_toggle_linewise_current)')
r('v', '<Leader>c', '<Plug>(comment_toggle_linewise_visual)')

-- utilities
r('i', 'jj', '<ESC>')
s('n', '<ESC><ESC>', ':<C-u>lua require("globals").toggle_hlsearch()<CR>')
s('n', ';', ':<C-u>lua require("telescope.builtin").buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>')
s('n', '<C-q>', ':<C-u>CloseBuffer<CR>')

r('n', '*', '<Plug>(asterisk-z*)')
r('n', 'n', '<Plug>(quickhl-manual-go-to-next)')
r('n', 'N', '<Plug>(quickhl-manual-go-to-prev)')

s('n', '<C-u>', ':lua require("globals").pageup()<CR>')
s('n', '<C-d>', ':lua require("globals").pagedown()<CR>')

s('n', '<C-y>', ':<C-u>LinediffReset<CR>')
s('v', '<C-y>', ':Linediff<CR>')

r('n', '<C-a>', 'g<Plug>(dial-increment)')
r('n', '<C-x>', 'g<Plug>(dial-decrement)')

-- <C-f> find files
r('n', '<C-f>', '<Nop>')
s('n', '<C-f><C-f>', ':<C-u>lua require("telescope.builtin").find_files()<CR>')

-- <C-g> git
r('n', '<C-g>', '<Nop>')
s('n', '<C-g><C-o>', ':<C-u>Goacf<CR>')
s('n', '<C-g><C-g>', ':<C-u>lua require("telescope").extensions.git_status.git_status()<CR>')
s('n', '<C-g><C-k>', ':<C-u>lua require("telescope").extensions.git_commit.git_commit()<CR>')
s('n', '<C-g><C-l>', ':<C-u>lua require("telescope").extensions.git_log.list_commits_on_file()<CR>')
s('n', '<C-g><C-p>', ':<C-u>Gitsigns prev_hunk<CR>')
s('n', '<C-g><C-n>', ':<C-u>Gitsigns next_hunk<CR>')
s({ 'n', 'v' }, '<C-g><C-h>', '<CMD>Gitsigns reset_hunk<CR>')
s({ 'n', 'v' }, '<C-g><C-j>', '<CMD>Gitsigns stage_hunk<CR>')

-- <C-w> filer
r('n', '<C-w>', '<Nop>')
s('n', '<C-w><C-w>', ':<C-u>lua require("telescope").extensions.file_browser.file_browser({ initial_mode = "normal" })<CR>')

-- <C-e> test
r('n', '<C-e>', '<Nop>')
s('n', '<C-e><C-e>', ':<C-u>lua require("globals").toggle_rspec_file()<CR>')

-- <C-s> replacer
r('n', '<C-s>', '<Nop>')
s('n', '<C-s><C-s>', ':<C-u>lua require("telescope").extensions.convert_word_case.convert_word_case()<CR>')

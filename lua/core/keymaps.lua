--
-- Key mappings
--
local keymap = vim.keymap.set
local with_silent = {
  silent = true,
}
local with_remap = {
  remap = true,
}

keymap('c', '<C-a>', '<Home>', with_remap)
keymap('c', '<C-e>', '<End>', with_remap)
keymap('c', '<C-h>', '<Left>', with_remap)
keymap('c', '<C-l>', '<Right>', with_remap)

keymap('n', 'Z', '<Nop>', with_remap)
keymap('n', 'Q', '<Nop>', with_remap)
keymap('n', 'q', '<Nop>', with_remap)
keymap('n', 'q:', '<Nop>', with_remap)

keymap('n', 'j', '<Plug>(accelerated_jk_gj)', with_remap)
keymap('n', 'k', '<Plug>(accelerated_jk_gk)', with_remap)
keymap('n', 'w', '<Plug>(smartword-w)', with_remap)
keymap('n', 'b', '<Plug>(smartword-b)', with_remap)
keymap('n', 'e', '<Plug>(smartword-e)', with_remap)

keymap('n', 's', '<Nop>', with_remap)
keymap({ 'n', 'v' }, 'sj', '<Plug>(edgemotion-j)', with_silent)
keymap({ 'n', 'v' }, 'sk', '<Plug>(edgemotion-k)', with_silent)
keymap({ 'n', 'v' }, 'sh', '^', with_silent)
keymap({ 'n', 'v' }, 'sl', '$', with_silent)
keymap({ 'n', 'v' }, 'ss', '<CMD>lua require("hop").hint_patterns({}, vim.fn.input("[HopWithWord] "))<CR>', with_silent)
keymap({ 'n', 'v' }, 'f', '<CMD>lua require("globals").hop_with_char({ direction = "after_cursor", current_line_only = true })<CR>', with_silent)
keymap({ 'n', 'v' }, 'F', '<CMD>lua require("globals").hop_with_char({ direction = "before_cursor", current_line_only = true })<CR>', with_silent)

-- leader family
vim.g.mapleader = " "
keymap('n', '<Space>', '<Nop>', with_remap)
keymap({ 'n', 'v' }, '<Leader>o', '<CMD>Gobf<CR>', with_silent)
keymap({ 'n', 'v' }, '<Leader>O', '<CMD>Gobfop<CR>', with_silent)
keymap('n', '<Leader>p', ':<C-u>Gocd<CR>', with_silent)
keymap('n', '<Leader>P', ':<C-u>Gopr<CR>', with_silent)

keymap('n', '<Leader>h', '<Plug>(quickhl-manual-reset)', with_silent)
keymap('n', '<Leader>j', '<Plug>(asterisk-z*)', with_silent)
keymap('n', '<Leader>k', ':<C-u>lua require("globals").toggle_hisearch()<CR>', with_silent)
keymap('n', '<Leader>l', '<Plug>(quickhl-manual-this)', with_silent)

keymap('n', '*', '<Plug>(asterisk-z*)', with_remap)
keymap('n', 'n', '<Plug>(quickhl-manual-go-to-next)', with_remap)
keymap('n', 'N', '<Plug>(quickhl-manual-go-to-prev)', with_remap)

keymap('n', '<Leader>n', ':<C-u>lua require("telescope.builtin").grep_string({ search = vim.fn.histget("@", -1) })<CR>', with_silent)
keymap('n', '<Leader>,', ':<C-u>lua require("telescope.builtin").grep_string({ search = require("globals").histadd_string(vim.fn.expand("<cword>")) })<CR>', with_silent)
keymap('n', '<Leader>m', ':<C-u>lua require("telescope.builtin").grep_string({ search = require("globals").histadd_string(vim.fn.input("[GrepString] ")) })<CR>', with_silent)

keymap('n', '<Leader>z', ':<C-u>ConfirmQuitAll<CR>', with_silent)
keymap('n', '<Leader>q', ':<C-u>ConfirmQuit<CR>', with_silent)
keymap('n', '<Leader>w', ':<C-u>w<CR>', with_silent)
keymap('n', '<Leader>W', ':<C-u>lua vim.lsp.buf.format({ async = true })<CR>', with_silent)

keymap('n', '<Leader>c', '<Plug>(comment_toggle_linewise_current)', with_remap)
keymap('v', '<Leader>c', '<Plug>(comment_toggle_linewise_visual)', with_remap)

keymap('n', '<Leader>x', ':<C-u>lua require("globals").toggle_rspec_file()<CR>', with_silent)

-- utilities
keymap('i', 'jj', '<ESC>', with_remap)
keymap('n', ';', ':<C-u>lua require("telescope.builtin").buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>', with_silent)
keymap('n', '<C-q>', ':<C-u>lua require("globals").close_buffer()<CR>', with_silent)

keymap('n', '<C-y>', ':<C-u>LinediffReset<CR>', with_silent)
keymap('v', '<C-y>', ':Linediff<CR>', with_silent)

keymap('n', '<C-x>', '<Plug>(dial-decrement)', with_remap)
keymap('n', '<C-a>', '<Plug>(dial-increment)', with_remap)

-- " <C-f> Find files
keymap('n', '<C-f>', '<Nop>', with_remap)
keymap('n', '<C-f><C-f>', ':<C-u>lua require("telescope.builtin").find_files()<CR>', with_silent)

-- " <C-g> Git
keymap('n', '<C-g>', '<Nop>', with_remap)
keymap('n', '<C-g><C-g>', ':<C-u>lua require("telescope.builtin").git_status({ initial_mode = "normal" })<CR>', with_silent)
keymap('n', '<C-g><C-o>', ':<C-u>Goacf<CR>', with_silent)
keymap('n', '<C-g><C-l>', ':<C-u>lua require("telescope").extensions.git_log.list_commits_on_file()<CR>', with_silent)
keymap('n', '<C-g><C-p>', ':<C-u>Gitsigns prev_hunk<CR>', with_silent)
keymap('n', '<C-g><C-n>', ':<C-u>Gitsigns next_hunk<CR>', with_silent)
keymap({ 'n', 'v' }, '<C-g><C-h>', '<CMD>Gitsigns reset_hunk<CR>', with_silent)

-- " <C-w> Filer
keymap('n', '<C-w>', '<Nop>', with_remap)
keymap('n', '<C-w><C-w>', ':<C-u>lua require("telescope").extensions.file_browser.file_browser({ initial_mode = "normal" })<CR>', with_silent)

-- " <C-e> LSP
keymap('n', '<C-e>', '<Nop>', with_remap)
keymap('n', '<C-e><C-e>', ':<C-u>lua vim.lsp.buf.definition()<CR>', with_silent)
keymap('n', '<C-e><C-r>', ':<C-u>lua vim.lsp.buf.references()<CR>', with_silent)
keymap('n', '<C-e>r', ':<C-u>lua vim.lsp.buf.rename()<CR>', with_silent)
keymap('n', '=', ':<C-u>lua require("globals").toggle_lsp_lines_text()<CR>', with_silent)

-- " <C-s> Replacer
keymap('n', '<C-s>', '<Nop>', with_remap)
keymap('n', '<C-s><C-s>', ':<C-u>lua require("telescope").extensions.convert_word_case.convert_word_case()<CR>', with_silent)

-- " Moving window
keymap('n', '<C-j>', '<C-w><C-j>', with_silent)
keymap('n', '<C-k>', '<C-w><C-k>', with_silent)
keymap('n', '<C-l>', '<C-w><C-l>', with_silent)
keymap('n', '<C-h>', '<C-w><C-h>', with_silent)

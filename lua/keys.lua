--
-- Key mappings
--
--
-- [[Text Objects]]
-- Thanks to https://shnsprk.com/entry/2015/11/12/070000
--
-- Operator + a/i + Object
--
-- [Operator]
-- c: change
-- d: delete
-- y: yank
-- (v: visual)
--
-- [a/i]
-- a: an object
-- i: inner
--
-- [Object]
-- w: word
-- W: WORD (with white space)
-- s: sentence (bun)
-- p: paragraph (danraku)
-- t: tag (html tag)
-- ' " ` [ { <: 'inner from symbol'
--
-- [[vim-sandwich]]
-- Thanks to https://github.com/machakann/vim-sandwich
--   and https://machakann.hatenablog.com/entry/2015/07/25/205921
--
-- sa: surround add
--  `saiw(` pattern: foo => (foo)
-- sd: surround delete
--  `sd(` pattern: (foo) => foo
-- sr: surround replace
--  `sr("` pattern: (foo) => "foo"
--
-- Custom mappings
--
-- * If you cannot apply your key mappings, you can see like ':verbose imap <C-h>' and can trace whole settings about it.
vim.cmd([[
  " Do NOT quit on command mode.
  " This config is inspired by https://zenn.dev/monaqa/articles/2020-12-22-vim-abbrev
  cabbrev <expr> q (getcmdtype() ==# ":" && getcmdline() ==# "q") ? "echo 'use :quit'" : "q"
  cabbrev <expr> wq (getcmdtype() ==# ":" && getcmdline() ==# "wq") ? "echo 'use :quit'" : "wq"
  cabbrev <expr> xa (getcmdtype() ==# ":" && getcmdline() ==# "xa") ? "echo 'use :quit'" : "xa"
  " Disable unuse commands
  nmap <C-z> <Nop>
  nnoremap Z <Nop>
  nnoremap Q <Nop>
  nnoremap q: <Nop>

  " <Space> Leaders
  let mapleader="\<Space>"
  nnoremap <silent> <Leader><Leader> :<C-u>lua require('global_functions').toggle_lsp_lines_text()<CR>
  nnoremap <silent> <Leader>a :<C-u>lua require('actions-preview').code_actions()<CR>
  " github integrations
  nnoremap <silent> <Leader>o :<C-u>Gobf<CR>
  vnoremap <silent> <Leader>o :Gobf<CR>
  nnoremap <silent> <Leader>O :<C-u>lua require('gobf').open_git_blob_file({ target_hash = vim.fn.input('[CommitHash] ')})<CR>
  nnoremap <silent> <Leader>p :<C-u>Gocd<CR>
  nnoremap <silent> <Leader>P :<C-u>Gopr<CR>
  " grep words
  nnoremap <silent> <Leader>n :<C-u>lua require('telescope.builtin').grep_string({ search = vim.fn.histget('@', -1) })<CR>
  nnoremap <silent> <Leader>N :<C-u>lua require('telescope.builtin').live_grep({ default_text = vim.fn.histget('@', -1) })<CR>
  nnoremap <silent> <Leader>, :<C-u>lua require('telescope.builtin').grep_string({ search = require('global_functions').cword_as_input() })<CR>
  nnoremap <silent> <Leader>< :<C-u>lua require('telescope.builtin').live_grep({ default_text = require('global_functions').cword_as_input() })<CR>
  nnoremap <silent> <Leader>m :<C-u>lua require('telescope.builtin').grep_string({ search = vim.fn.input('[GrepString] ') })<CR>
  nnoremap <silent> <Leader>M :<C-u>lua require('telescope.builtin').live_grep({ default_text = vim.fn.input('[LiveGrep] ') })<CR>
  " buffers
  nnoremap <Leader>w :<C-u>w<CR>
  nnoremap <silent> <Leader>W :lua vim.lsp.buf.format({ async = true })<CR>
  " comments
  nmap <Leader>c <Plug>(comment_toggle_linewise_current)
  vmap <Leader>c <Plug>(comment_toggle_linewise_visual)
  " rspecs
  nnoremap <silent> <Leader>x :<C-u>RSpecJump!<CR>
  nnoremap <silent> <Leader>z :<C-u>RSpecCurrentFile<CR>
  nnoremap <silent> <Leader>Z :<C-u>RSpecNearest<CR>
  nnoremap <silent> <C-z> :<C-u>RSpecShowLastResult<CR>
  " diff lines
  vnoremap <silent> <C-y> :Linediff<CR>
  nnoremap <silent> <C-y> :<C-u>LinediffReset<CR>
  " utilities
  inoremap <silent> jj <ESC>
  nnoremap <silent> <Esc><Esc> :noh<CR>
  nnoremap <silent> ; :<C-u>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>
  nnoremap <silent> <C-q> :<C-u>lua require('global_functions').close_buffer()<CR>

  " <C-f> Find files
  nmap <C-f> <Nop>
  nnoremap <silent> <C-f><C-f> :<C-u>lua require('telescope.builtin').find_files()<CR>
  nnoremap <silent> <C-f><C-j> :<C-u>lua require('telescope.builtin').oldfiles()<CR>

  " <C-g> Git
  nmap <C-g> <Nop>
  nnoremap <silent> <C-g><C-g> :<C-u>lua require('gitsigns').setqflist('all')<CR>
  nnoremap <silent> <C-g><C-o> :<C-u>Goacf<CR>
  nnoremap <silent> <C-g><C-l> :<C-u>lua require('telescope').extensions.git_log.list_commits_on_file()<CR>
  nnoremap <silent> <C-g><C-p> :<C-u>Gitsigns prev_hunk<CR>
  nnoremap <silent> <C-g><C-n> :<C-u>Gitsigns next_hunk<CR>
  nnoremap <silent> <C-g><C-j> :<C-u>Gitsigns undo_stage_hunk<CR>
  nnoremap <silent> <C-g><C-k> :<C-u>Gitsigns stage_hunk<CR>
  vnoremap <silent> <C-g><C-k> :Gitsigns stage_hunk<CR>
  nnoremap <silent> <C-g><C-h> :<C-u>Gitsigns reset_hunk<CR>
  vnoremap <silent> <C-g><C-h> :Gitsigns reset_hunk<CR>
  nnoremap <silent> <C-g>j :<C-u>Gitsigns toggle_deleted<CR>
  nnoremap <silent> <C-g>k :<C-u>Gitsigns stage_buffer<CR>
  nnoremap <silent> <C-g>h :<C-u>Gitsigns reset_buffer<CR>
  nnoremap <silent> + :<C-u>lua require('telescope').extensions.gh_pr.list({ remote = 'upstream', search = 'is:pr is:open user-review-requested:@me' })<CR>
  nnoremap <silent> _ :<C-u>lua require('telescope').extensions.gh_pr.list({ remote = 'upstream' })<CR>

  " <C-w> Filer
  nmap <C-w> <Nop>
  nmap <silent> <C-w><C-q> :<C-u>close<CR>
  nnoremap <silent> <C-w><C-w> :<C-u>lua require('telescope').extensions.file_browser.file_browser({ initial_mode = 'normal' })<CR>

  " <C-e> LSP
  nmap <C-e> <Nop>
  nnoremap <silent> <C-e><C-e> :<C-u>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <C-e><C-r> :<C-u>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> <C-e><C-d> :<C-u>lua vim.lsp.buf.rename()<CR>

  " Moving cursor
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
  " Moving panes
  nnoremap <C-j> <C-w><C-j>
  nnoremap <C-k> <C-w><C-k>
  nnoremap <C-l> <C-w><C-l>
  nnoremap <C-h> <C-w><C-h>

  " Moving hop keyword
  nnoremap s <Nop>
  " sa: surround add
  "  `saiw(` pattern: foo => (foo)
  " sd: surround delete
  "  `sd(` pattern: (foo) => foo
  " sr: surround replace
  "  `sr("` pattern: (foo) => "foo"
  nnoremap ss :<C-u>TextCaseOpenTelescope<CR>
  nnoremap sj <Plug>(edgemotion-j)
  vnoremap sj <Plug>(edgemotion-j)
  nnoremap sk <Plug>(edgemotion-k)
  vnoremap sk <Plug>(edgemotion-k)
  nnoremap sh ^
  vnoremap sh ^
  nnoremap sl $
  vnoremap sl $
  nnoremap f :<C-u>HopChar1CurrentLineAC<CR>
  vnoremap f <CMD>HopChar1CurrentLineAC<CR>
  nnoremap F :<C-u>HopChar1CurrentLineBC<CR>
  vnoremap F <CMD>HopChar1CurrentLineBC<CR>
  nnoremap H :<C-u>lua require('tsht').move({ side = "start" })<CR>
  nnoremap L :<C-u>lua require('tsht').move({ side = "end" })<CR>
  nnoremap K :<C-u>SymbolsOutline<CR>

  " github copilot
  " see https://github.com/github/copilot.vim/blob/release/doc/copilot.txt
  imap <silent> <C-j> <Plug>(copilot-next)
  imap <silent> <C-k> <Plug>(copilot-previous)
  imap <silent> <C-h> <Plug>(copilot-dismiss)
  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
]])

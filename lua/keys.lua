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
  " https://stackoverflow.com/questions/11828270/how-do-i-exit-vim
  function! s:command_solver(target)
    return (getcmdtype() == ':' && getcmdline() ==# a:target)
  endfunction

  cnoreabbrev <expr> x <SID>command_solver('x') ? 'ConfirmQuit' : 'x'
  cnoreabbrev <expr> q <SID>command_solver('q') ? 'ConfirmQuit' : 'q'
  cnoreabbrev <expr> wq <SID>command_solver('wq') ? 'ConfirmQuit' : 'wq'
  cnoreabbrev <expr> xa <SID>command_solver('xa') ? 'ConfirmQuitAll' : 'xa'
  cnoreabbrev <expr> qa <SID>command_solver('qa') ? 'ConfirmQuitAll' : 'qa'
  cnoremap quit :<C-u>ConfirmQuit<CR>

  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>
  cnoremap <C-h> <Left>
  cnoremap <C-l> <Right>

  " Disable unuse commands
  nnoremap Z <Nop>
  nnoremap Q <Nop>
  nnoremap q <Nop>
  nnoremap q: <Nop>

  " <Space> Leaders
  let mapleader="\<Space>"
  " github integrations
  nnoremap <silent> <Leader>o :<C-u>Gobf<CR>
  vnoremap <silent> <Leader>o :Gobf<CR>
  nnoremap <silent> <Leader>O :<C-u>lua require('gobf').open_git_blob_file({ target_hash = vim.fn.input('[CommitHash] ')})<CR>
  nnoremap <silent> <Leader>p :<C-u>Gocd<CR>
  nnoremap <silent> <Leader>P :<C-u>Gopr<CR>
  " grep words
  nnoremap <silent> <Leader>n :<C-u>lua require('telescope.builtin').grep_string({ search = vim.fn.histget('@', -1) })<CR>
  nnoremap <silent> <Leader>N :<C-u>lua require("telescope").extensions.live_grep_args.live_grep_args({ default_text = vim.fn.histget('@', -1) })<CR>
  nnoremap <silent> <Leader>, :<C-u>lua require('telescope.builtin').grep_string({ search = require('global_functions').cword_as_input() })<CR>
  nnoremap <silent> <Leader>< :<C-u>lua require("telescope").extensions.live_grep_args.live_grep_args({ default_text = require('global_functions').cword_as_input() })<CR>
  nnoremap <silent> <Leader>m :<C-u>lua require('telescope.builtin').grep_string({ search = vim.fn.input('[GrepString] ') })<CR>
  nnoremap <silent> <Leader>M :<C-u>lua require("telescope").extensions.live_grep_args.live_grep_args({ default_text = vim.fn.input('[LiveGrep] ') })<CR>
  " memo
  nnoremap <silent> <Leader><Leader> :<C-u>lua require('global_functions').start_memo()<CR>
  nnoremap <silent> <Leader>x :<C-u>lua require('telescope').extensions.memo.grep_string({ search = vim.fn.input('[MemoString] ') })<CR>
  nnoremap <silent> <Leader>X :<C-u>lua require('telescope').extensions.memo.live_grep({ default_text = require('global_functions').cword_as_input() })<CR>
  " buffers
  nnoremap <Leader>w :<C-u>w<CR>
  nnoremap <silent> <Leader>W :lua vim.lsp.buf.format({ async = true })<CR>
  " comments
  nmap <Leader>c <Plug>(comment_toggle_linewise_current)
  vmap <Leader>c <Plug>(comment_toggle_linewise_visual)
  " diff lines
  vnoremap <silent> <C-y> :Linediff<CR>
  nnoremap <silent> <C-y> :<C-u>LinediffReset<CR>
  " utilities
  inoremap <silent> jj <ESC>
  nnoremap <silent> <Esc><Esc> :noh<CR>
  nnoremap <silent> ; :<C-u>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>
  nnoremap <silent> <C-q> :<C-u>lua require('global_functions').close_buffer()<CR>

  " <C-z> rspec
  nmap <C-z> <Nop>
  nnoremap <silent> <C-z><C-z> :<C-u>RSpecJump!<CR>
  nnoremap <silent> <C-z><C-j> :<C-u>RSpecCurrentFile<CR>
  nnoremap <silent> <C-z><C-k> :<C-u>RSpecNearest<CR>
  nnoremap <silent> <C-z><C-l> :<C-u>RSpecShowLastResult<CR>

  " <C-f> Find files
  nmap <C-f> <Nop>
  nnoremap <silent> <C-f><C-f> :<C-u>lua require('telescope.builtin').find_files()<CR>
  nnoremap <silent> <C-f><C-j> :<C-u>lua require('telescope.builtin').oldfiles()<CR>

  " <C-g> Git
  nmap <C-g> <Nop>
  nnoremap <silent> <C-g><C-g> :<C-u>lua require('telescope.builtin').git_status()<CR>
  nnoremap <silent> <C-g><C-o> :<C-u>Goacf<CR>
  nnoremap <silent> <C-g><C-l> :<C-u>lua require('telescope').extensions.git_log.list_commits_on_file()<CR>
  nnoremap <C-g><C-p> :<C-u>Gitsigns prev_hunk<CR>
  nnoremap <C-g><C-n> :<C-u>Gitsigns next_hunk<CR>
  nnoremap <C-g><C-j> :<C-u>Gitsigns undo_stage_hunk<CR>
  nnoremap <C-g><C-k> :<C-u>Gitsigns stage_hunk<CR>
  vnoremap <C-g><C-k> :Gitsigns stage_hunk<CR>
  nnoremap <C-g><C-h> :<C-u>Gitsigns reset_hunk<CR>
  vnoremap <C-g><C-h> :Gitsigns reset_hunk<CR>
  nnoremap - :<C-u>Gitsigns toggle_deleted<CR>
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
  nnoremap <silent> <C-e>r :<C-u>lua vim.lsp.buf.rename()<CR>
  nnoremap = :<C-u>lua require('global_functions').toggle_lsp_lines_text()<CR>

  " <C-x> Actions
  nmap <C-x> <Nop>
  nnoremap <silent> <C-x><C-x> :<C-u>lua require('actions-preview').code_actions()<CR>

  " <C-s> Motion
  nmap <C-s> <Nop>
  nnoremap <silent> <C-s><C-s> :<C-u>lua require('telescope').extensions.convert_word_case.convert_word_case()<CR>

  " <C-a> Telescope
  nmap <C-a> <Nop>
  nnoremap <silent> <C-a><C-a> :<C-u>Telescope<CR>

  " <C-t> Nop (tmux prefix)
  nmap <C-t> <Nop>

  " Moving cursor
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
  nmap w <Plug>(smartword-w)
  nmap b <Plug>(smartword-b)
  nmap e <Plug>(smartword-e)
  nmap ge <Plug>(smartword-ge)
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
  nnoremap <silent> ss :<C-u>lua require('global_functions').move_to_start_context()<CR>
  nnoremap sm <Plug>(matchup-%)
  nnoremap sj <Plug>(edgemotion-j)
  vnoremap sj <Plug>(edgemotion-j)
  nnoremap sk <Plug>(edgemotion-k)
  vnoremap sk <Plug>(edgemotion-k)
  nnoremap sh ^
  vnoremap sh ^
  nnoremap sl $
  vnoremap sl $
  nnoremap f :<C-u>HopPatternCurrentLineAC<CR>
  vnoremap f <CMD>HopPatternCurrentLineAC<CR>
  nnoremap F :<C-u>HopPatternCurrentLineBC<CR>
  vnoremap F <CMD>HopPatternCurrentLineBC<CR>
  nnoremap t :<C-u>HopNode<CR>
  vnoremap t <CMD>HopNode<CR>
  nnoremap L :<C-u>HopPatternAC<CR>
  vnoremap L <CMD>HopPatternAC<CR>
  nnoremap H :<C-u>HopPatternBC<CR>
  vnoremap H <CMD>HopPatternBC<CR>

  " github copilot
  " see https://github.com/github/copilot.vim/blob/release/doc/copilot.txt
  imap <silent> <C-j> <Plug>(copilot-next)
  imap <silent> <C-k> <Plug>(copilot-previous)
  imap <silent> <C-h> <Plug>(copilot-dismiss)
  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
]])

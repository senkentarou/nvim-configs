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
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>
  cnoremap <C-h> <Left>
  cnoremap <C-l> <Right>

  " Disable unuse commands
  " close
  nnoremap Z <Nop>
  nnoremap Q <Nop>
  " macro
  nnoremap q <Nop>
  " command line window
  nnoremap q: <Nop>

  " <Space> Leaders
  let mapleader="\<Space>"
  nnoremap <silent> <Leader><Leader> :<C-u>lua require('treesj').toggle()<CR>
  " Github integrations
  nnoremap <silent> <Leader>o :<C-u>Gobf<CR>
  vnoremap <silent> <Leader>o <CMD>Gobf<CR>
  nnoremap <silent> <Leader>O :<C-u>Gobfop<CR>
  vnoremap <silent> <Leader>O <CMD>Gobfop<CR>
  nnoremap <silent> <Leader>p :<C-u>Gocd<CR>
  nnoremap <silent> <Leader>P :<C-u>Gopr<CR>
  " grep words
  nnoremap <silent> <Leader>n :<C-u>lua require('telescope.builtin').grep_string({ search = vim.fn.histget('@', -1) })<CR>
  nnoremap <silent> <Leader>, :<C-u>lua require('telescope.builtin').grep_string({ search = require('globals').histadd_string(vim.fn.expand("<cword>")) })<CR>
  nnoremap <silent> <Leader>m :<C-u>lua require('telescope.builtin').grep_string({ search = require('globals').histadd_string(vim.fn.input('[GrepString] ')) })<CR>
  " find char
  nnoremap <silent> <Leader>f :<C-u>lua require('globals').hop_with_char()<CR>
  vnoremap <silent> <Leader>f <CMD>lua require('globals').hop_with_char()<CR>
  " snippet
  nnoremap <silent> <Leader>l :<C-u>lua require('telescope').extensions.luasnip.luasnip()<CR>
  " buffers
  nnoremap <Leader>z :<C-u>ConfirmQuitAll<CR>
  nnoremap <Leader>q :<C-u>ConfirmQuit<CR>
  nnoremap <Leader>w :<C-u>w<CR>
  nnoremap <silent> <Leader>W :lua vim.lsp.buf.format({ async = true })<CR>
  " comments
  nmap <Leader>c <Plug>(comment_toggle_linewise_current)
  vmap <Leader>c <Plug>(comment_toggle_linewise_visual)
  " rspec
  nnoremap <silent> <Leader>x :<C-u>lua require('globals').toggle_rspec_file()<CR>
  " utilities
  inoremap <silent> jj <ESC>
  nnoremap <silent> ; :<C-u>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>
  nnoremap <silent> <C-q> :<C-u>lua require('globals').close_buffer()<CR>
  vnoremap <silent> <C-y> :Linediff<CR>
  nnoremap <silent> <C-y> :<C-u>LinediffReset<CR>

  " <C-f> Find files
  nmap <C-f> <Nop>
  nnoremap <silent> <C-f><C-f> :<C-u>lua require('telescope.builtin').find_files()<CR>

  " <C-g> Git
  nmap <C-g> <Nop>
  nnoremap <silent> <C-g><C-g> :<C-u>lua require('telescope.builtin').git_status({ initial_mode = 'normal' })<CR>
  nnoremap <silent> <C-g><C-o> :<C-u>Goacf<CR>
  nnoremap <silent> <C-g><C-l> :<C-u>lua require('telescope').extensions.git_log.list_commits_on_file()<CR>
  nnoremap <C-g><C-p> :<C-u>Gitsigns prev_hunk<CR>
  nnoremap <C-g><C-n> :<C-u>Gitsigns next_hunk<CR>
  nnoremap <C-g><C-h> :<C-u>Gitsigns reset_hunk<CR>
  vnoremap <C-g><C-h> :Gitsigns reset_hunk<CR>

  " <C-w> Filer
  nmap <C-w> <Nop>
  nmap <silent> <C-w><C-q> :<C-u>close<CR>
  nnoremap <silent> <C-w><C-w> :<C-u>lua require('telescope').extensions.file_browser.file_browser({ initial_mode = 'normal' })<CR>

  " <C-e> LSP
  nmap <C-e> <Nop>
  nnoremap <silent> <C-e><C-e> :<C-u>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <C-e><C-r> :<C-u>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> <C-e>r :<C-u>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> K :<C-u>lua require('globals').toggle_lsp_lines_text()<CR>

  " <C-x> Nop
  nmap <C-x> <Nop>

  " <C-a> Nop
  nmap <C-a> <Nop>

  " <C-z> Nop
  nmap <C-z> <Nop>

  " <C-c> Nop (preserve for cancellation)
  nmap <C-c> <Nop>

  " <C-b> Nop (cannot reach left hand finger)
  nmap <C-b> <Nop>

  " <C-t> Nop (preserve for tmux prefix)
  nmap <C-t> <Nop>

  " <C-s> Motion
  nmap <C-s> <Nop>
  nnoremap <silent> <C-s><C-s> :<C-u>lua require('telescope').extensions.convert_word_case.convert_word_case()<CR>

  " Moving cursor
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
  nmap w <Plug>(smartword-w)
  nmap b <Plug>(smartword-b)
  nmap e <Plug>(smartword-e)

  " Moving hop keyword
  nnoremap s <Nop>
  " sa: surround add
  "  `saiw(` pattern: foo => (foo)
  " sd: surround delete
  "  `sd(` pattern: (foo) => foo
  " sr: surround replace
  "  `sr("` pattern: (foo) => "foo"
  nnoremap <silent> ss :<C-u>lua require('globals').move_to_context({ start = true })<CR>
  nnoremap <silent> qq :<C-u>lua require('globals').move_to_context({ end_ = true })<CR>
  nnoremap sm <Plug>(matchup-%)
  nnoremap sj <Plug>(edgemotion-j)
  vnoremap sj <Plug>(edgemotion-j)
  nnoremap sk <Plug>(edgemotion-k)
  vnoremap sk <Plug>(edgemotion-k)
  nnoremap sh ^
  vnoremap sh ^
  nnoremap sl $
  vnoremap sl $
  nnoremap sm :<C-u>HopNode<CR>
  vnoremap sm <CMD>HopNode<CR>
  nnoremap sn :<C-u>lua require('globals').hop_with_word({ latest_search = true })<CR>
  vnoremap sn <CMD>lua require('globals').hop_with_word({ latest_search = true })<CR>
  nnoremap s, :<C-u>lua require('globals').hop_with_word({ current_cursor = true })<CR>
  vnoremap s, <CMD>lua require('globals').hop_with_word({ current_cursor = true })<CR>
  nnoremap <silent> f :<C-u>lua require('globals').hop_with_char({ direction = 'after_cursor' })<CR>
  vnoremap <silent> f <CMD>lua require('globals').hop_with_char({ direction = 'after_cursor' })<CR>
  nnoremap <silent> F :<C-u>lua require('globals').hop_with_char({ direction = 'before_cursor' })<CR>
  vnoremap <silent> F <CMD>lua require('globals').hop_with_char({ direction = 'before_cursor' })<CR>

  " Moving window
  nnoremap <C-j> <C-w><C-j>
  nnoremap <C-k> <C-w><C-k>
  nnoremap <C-l> <C-w><C-l>
  nnoremap <C-h> <C-w><C-h>
]])
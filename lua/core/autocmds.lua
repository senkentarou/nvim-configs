local my_autocmds = vim.api.nvim_create_augroup('MyAutocmds', {
  clear = true,
})

vim.api.nvim_create_autocmd({
  'BufWritePre',
}, {
  group = my_autocmds,
  pattern = '*',
  command = '%s/\\s\\+$//ge',
})

vim.api.nvim_create_autocmd({
  'FileType',
}, {
  group = my_autocmds,
  pattern = '*',
  command = 'setlocal formatoptions-=ro',
})

vim.api.nvim_create_autocmd({
  'BufNewFile',
  'BufRead',
}, {
  group = my_autocmds,
  pattern = '*.jsx',
  command = 'set filetype=javascriptreact',
})

vim.api.nvim_create_autocmd({
  'BufNewFile',
  'BufRead',
}, {
  group = my_autocmds,
  pattern = '*.tsx',
  command = 'set filetype=typescriptreact',
})

vim.api.nvim_create_autocmd({
  'BufNewFile',
  'BufRead',
}, {
  group = my_autocmds,
  pattern = '*.tsx',
  command = 'set filetype=typescriptreact',
})

vim.api.nvim_create_autocmd({
  'VimEnter',
  'ColorScheme',
}, {
  group = my_autocmds,
  pattern = '*',
  callback = function()
    vim.api.nvim_exec(
      [[
        highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
        highlight link DiffAdded DiffAdd
        highlight link DiffRemoved DiffDelete
      ]],
      false
    )
  end,
})

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

-- Filetype mappings
local filetype_mappings = {
  { pattern = '*.jsx', filetype = 'javascriptreact' },
  { pattern = '*.tsx', filetype = 'typescriptreact' },
  { pattern = '*.js', filetype = 'javascript' },
  { pattern = '*.ts', filetype = 'typescript' },
  { pattern = '*.sh', filetype = 'sh' },
  { pattern = '*.lua', filetype = 'lua' },
  { pattern = '*.yaml', filetype = 'yaml' },
  { pattern = '*.yml', filetype = 'yaml' },
  { pattern = '*.json', filetype = 'json' },
  { pattern = '*.tf', filetype = 'terraform' },
  { pattern = '*.toml', filetype = 'toml' },
  { pattern = '.tmux.conf', filetype = 'tmux' },
  { pattern = '*.gql', filetype = 'graphql' },
  { pattern = '*.graphql', filetype = 'graphql' },
}

for _, mapping in ipairs(filetype_mappings) do
  vim.api.nvim_create_autocmd({
    'BufNewFile',
    'BufRead',
  }, {
    group = my_autocmds,
    pattern = mapping.pattern,
    command = 'set filetype=' .. mapping.filetype,
  })
end

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

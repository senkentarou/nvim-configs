require('nvim-treesitter.configs').setup {
  autoload = {
    enable = true,
    require('nvim-ts-autotag').setup {
      enable_rename = false,
      filetypes = {
        'html',
        'xml',
        'tsx',
        'typescript',
        'typescriptreact',
      },
    },
  },
  ensure_installed = {
    'ruby',
    'html',
    'lua',
    'typescript',
    'javascript',
    'tsx',
    'vim',
    'markdown',
    'bash',
    'vimdoc',
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },
  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
}

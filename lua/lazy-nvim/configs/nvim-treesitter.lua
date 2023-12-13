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

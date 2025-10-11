local configs = function()
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
      'graphql',
      'terraform',
      'json',
      'yaml',
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
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
    },
    config = configs,
  },
}

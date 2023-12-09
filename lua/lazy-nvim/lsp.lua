return {
  {
    'williamboman/mason.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'j-hui/fidget.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
      'jose-elias-alvarez/typescript.nvim',
    },
    config = function()
      require('lazy-nvim.configs.nvim-lspconfig')
    end,
  },
  {
    'Maan2003/lsp_lines.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'aznhe21/actions-preview.nvim',
    opts = {
      -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
      diff = {
        algorithm = 'patience',
        ignore_whitespace = true,
      },
      backend = {
        'telescope',
      },
      telescope = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = 'top',
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
  },
}

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
    init = function()
      vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = true,
        virtual_lines = false,
      })
    end,
    opts = {},
  },
}

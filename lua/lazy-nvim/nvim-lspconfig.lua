return {
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
}

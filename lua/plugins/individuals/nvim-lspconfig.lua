local configs = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local nvim_lsp = require('lspconfig')

  nvim_lsp.ruby_lsp.setup {
    root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
    cmd = {
      'ruby-lsp',
    },
    filetypes = {
      'ruby',
      'rspec',
    },
    capabilities = capabilities,
  }
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
      'jose-elias-alvarez/typescript.nvim',
    },
    config = configs,
  },
}

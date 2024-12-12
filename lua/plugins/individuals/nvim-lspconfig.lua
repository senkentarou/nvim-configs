local configs = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities() -- nvim-cmpで補完候補にLSPを追加するための設定
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
    event = 'BufRead',
    config = configs,
  },
}

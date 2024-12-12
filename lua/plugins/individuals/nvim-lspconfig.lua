local configs = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities() -- nvim-cmpで補完候補にLSPを追加するための設定
  local nvim_lsp = require('lspconfig')

  nvim_lsp.ruby_lsp.setup {
    root_dir = nvim_lsp.util.root_pattern('Gemfile', '.git'),
    filetypes = {
      'ruby',
      'rspec',
    },
    capabilities = capabilities,
  }
  nvim_lsp.eslint.setup {
    root_dir = nvim_lsp.util.root_pattern('package.json', '.git'),
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    capabilities = capabilities,
  }
  -- null-ls: formatting for js/ts/jsx/tsx
  --  prettier: use for formatting
  local null_ls = require('null-ls')
  null_ls.setup {
    root_dir = nvim_lsp.util.root_pattern('package.json', '.git'),
    sources = {
      null_ls.builtins.formatting.prettier.with {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
      },
    },
  }
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
    },
    event = 'BufRead',
    config = configs,
  },
}

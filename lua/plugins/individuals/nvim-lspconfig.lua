local mason_config = function()
  local lsp_servers = {
    'ruby_lsp',
    'eslint',
    'lua_ls',
  }
  local formatters = {
    'stylua',
    'prettier',
  }
  local linter_diagnostics = {
    'selene',
  }

  require('mason').setup()
  require('mason-lspconfig').setup({
    -- install lsp servers
    ensure_installed = lsp_servers,
  })
  require('mason-null-ls').setup({
    -- install formatters and diagnostics servers
    ensure_installed = vim.tbl_flatten({ formatters, linter_diagnostics }),
  })
end

local lsp_config = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities() -- nvim-cmpで補完候補にLSPを追加するための設定
  local nvim_lsp = require('lspconfig')

  -- RubyOnRails
  -- lsp: ruby_lsp
  -- formatter: ruby_lsp(rubocop)
  -- linter(diagnostics): ruby_lsp(rubocop)
  nvim_lsp.ruby_lsp.setup({
    root_dir = nvim_lsp.util.root_pattern('Gemfile', '.git'),
    filetypes = {
      'ruby',
      'rspec',
    },
    capabilities = capabilities,
  })
  -- React+TypeScript
  -- lsp:
  -- formatter:
  -- linter(diagnostics):
  nvim_lsp.eslint.setup({
    root_dir = nvim_lsp.util.root_pattern('package.json', '.git'),
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    capabilities = capabilities,
  })
  -- Lua
  -- lsp: lua_ls
  -- formatter: stylua (null-ls)
  -- linter(diagnostics): selene (null-ls)
  nvim_lsp.lua_ls.setup({
    root_dir = nvim_lsp.util.root_pattern('.luarc.json', '.git'),
    capabilities = capabilities,
  })

  -- null-ls settings
  local null_ls = require('null-ls')
  null_ls.setup({
    root_dir = nvim_lsp.util.root_pattern('package.json', '.git'),
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.selene,
      null_ls.builtins.formatting.prettier.with({
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
      }),
    },
  })
end

return {
  {
    'williamboman/mason.nvim',
    -- see https://namileriblog.com/mac/lazy_nvim_lsp/
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    event = 'BufRead',
    config = mason_config,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
    },
    event = 'BufRead',
    config = lsp_config,
  },
}

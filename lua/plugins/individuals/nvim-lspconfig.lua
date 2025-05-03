local mason_config = function()
  local lsp_servers = {
    'ruby_lsp',
    'ts_ls',
    'biome',
    'eslint',
    'lua_ls',
    'bashls',
    'jsonls',
    'yamlls',
    'dockerls',
  }
  local formatters = {
    'rubocop', -- needs to use local project settings
    'prettier',
    'stylua',
    'shfmt',
  }
  local linter_diagnostics = {
    'selene',
    'shellcheck', -- needs to use bashls: see https://github.com/bash-lsp/bash-language-server
    -- 'hadolint', -- mason経由で入れるとdiagnosticsが表示されないので一時的にコメントアウト。brewなりで直接入れる。https://github.com/hadolint/hadolint
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

-- setting references:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
-- Deprecated contents: https://github.com/nvimtools/none-ls.nvim/discussions/81
local lsp_config = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities() -- nvim-cmpで補完候補にLSPを追加するための設定
  local nvim_lsp = require('lspconfig')
  local rails_rspec = {
    'ruby',
    'rspec',
  }
  local typescript_react = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  }

  -- RubyOnRails
  -- lsp: ruby_lsp
  -- formatter: ruby_lsp(rubocop)
  -- linter(diagnostics): ruby_lsp(rubocop)
  nvim_lsp.ruby_lsp.setup({
    root_dir = nvim_lsp.util.root_pattern('Gemfile', '.git'),
    filetypes = rails_rspec,
    capabilities = capabilities,
  })

  -- React+TypeScript
  -- lsp: ts_ls
  -- formatter: biome
  -- linter(diagnostics): eslint(lsp)
  nvim_lsp.ts_ls.setup({
    root_dir = nvim_lsp.util.root_pattern('package.json', 'tsconfig.json', '.git'),
    filetypes = typescript_react,
    capabilities = capabilities,
  })
  nvim_lsp.biome.setup({
    root_dir = nvim_lsp.util.root_pattern('package.json', 'biome.json', '.git'),
    filetypes = typescript_react,
    capabilities = capabilities,
  })
  -- use eslint lsp: see https://github.com/nvimtools/none-ls.nvim/discussions/81
  nvim_lsp.eslint.setup({
    root_dir = nvim_lsp.util.root_pattern('package.json', '.eslintrc.js', '.git'),
    filetypes = typescript_react,
    capabilities = capabilities,
  })

  -- Lua
  -- lsp: lua_ls
  -- formatter: stylua
  -- linter(diagnostics): selene
  nvim_lsp.lua_ls.setup({
    root_dir = nvim_lsp.util.root_pattern('.luarc.json', '.git'),
    capabilities = capabilities,
  })

  -- Bash
  -- lsp: bashls
  -- formatter: shfmt
  -- linter(diagnostics): bashls(shellcheck)
  nvim_lsp.bashls.setup({
    root_dir = nvim_lsp.util.root_pattern('.bashrc', '.git'),
    capabilities = capabilities,
  })

  -- JSON
  -- lsp: jsonls
  -- formatter: jsonls
  -- linter(diagnostics): jsonls
  -- ※ diagnostics autofix is not supported
  nvim_lsp.jsonls.setup({
    root_dir = nvim_lsp.util.root_pattern('.git'),
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        format = { enable = true },
        validate = { enable = true },
      },
    },
  })

  -- yaml
  -- lsp: yamlls
  -- formatter: yamlls
  -- linter(diagnostics): yamlls
  nvim_lsp.yamlls.setup({
    root_dir = nvim_lsp.util.root_pattern('.git'),
    capabilities = capabilities,
    settings = {
      yaml = {
        schemaStore = {
          -- use schemastore instead of built-in schemaStore
          enable = false,
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
        format = { enable = true },
        validate = true,
      },
    },
  })

  -- Dockerfile
  -- lsp: dockerls
  -- formatter: dockerls
  -- linter(diagnostics): hadolint
  nvim_lsp.dockerls.setup({
    root_dir = nvim_lsp.util.root_pattern('Dockerfile', '.hadolint.yaml', '.git'),
    capabilities = capabilities,
  })

  -- null-ls settings
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      -- Lua
      -- selene settings: see https://kampfkarren.github.io/selene/usage/configuration.html?highlight=toml#configuration
      null_ls.builtins.diagnostics.selene,
      null_ls.builtins.formatting.stylua,
      -- Bash
      null_ls.builtins.formatting.shfmt,
      -- Dockerfile
      null_ls.builtins.diagnostics.hadolint,
    },
  })
end

return {
  {
    'williamboman/mason.nvim',
    -- to learn plugins relationships, see https://namileriblog.com/mac/lazy_nvim_lsp/
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
      'b0o/schemastore.nvim',
    },
    event = 'BufRead',
    config = lsp_config,
  },
}

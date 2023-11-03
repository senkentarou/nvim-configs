local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')

nvim_lsp.ruby_ls.setup {
  init_options = {
    formatter = 'rubocop',
  },
  root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
  cmd = {
    'bundle',
    'exec',
    'ruby-lsp',
  },
  cmd_env = {
    BUNDLE_GEMFILE = vim.fn.getcwd() .. '/.ruby-lsp/Gemfile',
    BUNDLE_PATH__SYSTEM = 'true',
  },
  filetypes = {
    'ruby',
    'rspec',
  },
  on_attach = function(client, buffer)
    local callback = function()
      local params = vim.lsp.util.make_text_document_params(buffer)

      client.request('textDocument/diagnostic', {
        textDocument = params,
      }, function(err, result)
        if err then
          return
        end

        vim.lsp.diagnostic.on_publish_diagnostics(nil, vim.tbl_extend('keep', params, {
          diagnostics = result.items,
        }), {
          client_id = client.id,
        })
      end)
    end

    callback() -- call on attach

    vim.api.nvim_create_autocmd({
      'BufEnter',
      'BufWritePre',
      'BufReadPost',
      'InsertLeave',
      'TextChanged',
    }, {
      buffer = buffer,
      callback = callback,
    })
  end,
  capabilities = capabilities,
}

nvim_lsp.solargraph.setup {
  cmd = {
    'solargraph',
    'stdio',
  },
  init_options = {
    formatting = false,
  },
  filetypes = {
    'ruby',
    'rspec',
  },
  root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
  capabilities = capabilities,
}

nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  root_dir = require('lspconfig.util').root_pattern('.luarc.json', '.git'),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
}

nvim_lsp.bashls.setup {
  capabilities = capabilities,
}
nvim_lsp.yamlls.setup {
  capabilities = capabilities,
  filetypes = {
    'yml',
    'yaml',
  },
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}
nvim_lsp.jsonls.setup {
  capabilities = capabilities,
}
nvim_lsp.terraformls.setup {
  capabilities = capabilities,
}

-- null-ls: use diagnostics and formatting for js/ts/jsx/tsx
--   prettier: use for formatting
--   eslint: use for diagnostics (formatting is delegated to prettier)
-- see: https://zenn.dev/ryusou/articles/nodejs-prettier-eslint2021 and official documentation
local null_ls = require('null-ls')
null_ls.setup {
  root_dir = require('lspconfig.util').root_pattern('package.json', '.git'),
  sources = {
    null_ls.builtins.diagnostics.terraform_validate,
    null_ls.builtins.diagnostics.yamllint, -- see .yamllint
    null_ls.builtins.diagnostics.eslint_d.with {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      prefer_local = 'node_modules/.bin',
    },
    null_ls.builtins.formatting.prettier.with {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      prefer_local = 'node_modules/.bin',
    },
    null_ls.builtins.formatting.lua_format, -- see .lua-format
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.code_actions.shellcheck,
    require('typescript.extensions.null-ls.code-actions'),
  },
}

-- null-ls typescript integration
require('typescript').setup {
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
    -- filetypes = {'typescript', 'typescript.tsx', 'typescriptreact'}
    settings = {
      documentFormatting = false,
    },
    capabilities = capabilities,
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
    end,
  },
}
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = true,
  virtual_lines = false,
})

require('lsp_lines').setup()

require('actions-preview').setup {
  -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
  diff = {
    algorithm = 'patience',
    ignore_whitespace = true,
  },
  backend = {
    'telescope',
  },
  telescope = {
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = "top",
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}

require('mason').setup {}
require('mason-lspconfig').setup {}
require('mason-tool-installer').setup {}

require('lsp-colors').setup {
  Error = '#db4b4b',
  Warning = '#e0af68',
  Information = '#0db9d7',
  Hint = '#10B981',
}

require('fidget').setup {
  text = {
    spinner = 'pipe', -- animation shown when tasks are ongoing
    done = '✔', -- character shown when all tasks are complete
    commenced = 'Started', -- message shown when task starts
    completed = 'Completed', -- message shown when task completes
  },
}

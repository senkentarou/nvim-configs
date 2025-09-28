local lsp_servers = {
  'ts_ls',
  -- 'biome',
  'eslint',
  'lua_ls',
  'bashls',
}
local formatters = {
  'prettier',
  'stylua',
  'shfmt',
}
local linter_diagnostics = {
  'selene',
  'shellcheck', -- needs to use bashls: see https://github.com/bash-lsp/bash-language-server
}

local mason_config = function()
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
  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
      -- React+TypeScript
      null_ls.builtins.formatting.prettier,
    },
  })

  vim.lsp.enable(lsp_servers)
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
    },
    event = 'BufRead',
    config = lsp_config,
  },
}

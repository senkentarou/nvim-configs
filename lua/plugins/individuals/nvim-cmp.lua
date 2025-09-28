local configs = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = {
          buffer = '[Buf]',
          rg = '[RGrep]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[API]',
          path = '[Path]',
        },
      }),
    },
    window = {
      documentation = {
        border = {
          '╭',
          '─',
          '╮',
          '│',
          '╯',
          '─',
          '╰',
          '│',
        },
      },
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({
        select = false,
      }),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {
        'i',
        's',
      }),
    }),
    sources = cmp.config.sources({
      {
        name = 'buffer',
      },
      {
        name = 'rg',
        keyword_length = 3,
      },
      {
        name = 'nvim_lsp',
      },
      {
        name = 'nvim_lsp_signature_help',
      },
      {
        name = 'nvim_lua',
      },
      {
        name = 'path',
      },
    }, {
      {
        name = 'buffer',
      },
    }),
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {
        name = 'cmdline',
      },
    },
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      {
        name = 'buffer',
      },
    },
  })

  -- If you want insert `(` after select function or method item
  cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
end

return {
  {
    'hrsh7th/nvim-cmp',
    event = {
      'CmdlineEnter',
      'InsertEnter',
    },
    dependencies = {
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
    },
    config = configs,
  },
}

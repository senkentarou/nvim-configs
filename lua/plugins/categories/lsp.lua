return {
  {
    'j-hui/fidget.nvim',
    event = 'BufRead',
    init = function()
      vim.notify = require('fidget.notification').notify
    end,
    opts = {},
  },
  {
    'Maan2003/lsp_lines.nvim',
    event = 'BufRead',
    init = function()
      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        virtual_text = true,
        virtual_lines = false,
      })
    end,
    opts = {},
  },
}

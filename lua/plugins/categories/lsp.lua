return {
  {
    'j-hui/fidget.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'Maan2003/lsp_lines.nvim',
    event = 'BufRead',
    init = function()
      vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = true,
        virtual_lines = false,
      })
    end,
    opts = {},
  },
}

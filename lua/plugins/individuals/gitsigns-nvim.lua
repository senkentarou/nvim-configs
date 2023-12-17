return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
      }
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}

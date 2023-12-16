return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
      }
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    'senkentarou/gopr.nvim',
    event = 'BufRead',
    opts = {
      default_remote = 'upstream',
    },
  },
  {
    'senkentarou/gobf.nvim',
    event = 'BufRead',
    opts = {
      default_remote = 'upstream',
      default_branches = {
        'main',
        'master',
        'develop',
      },
    },
  },
  {
    'senkentarou/goacf.nvim',
    event = 'VimEnter',
  },
}

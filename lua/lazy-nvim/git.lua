return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
    },
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

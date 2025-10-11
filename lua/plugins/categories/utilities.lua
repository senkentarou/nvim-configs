return {
  {
    'rainbowhxch/accelerated-jk.nvim',
    event = 'VimEnter',
  },
  {
    'kana/vim-smartword',
    event = 'BufRead',
  },
  {
    'yutkat/wb-only-current-line.nvim',
    event = 'BufRead',
  },
  {
    't9md/vim-quickhl',
    event = 'BufRead',
  },
  {
    'haya14busa/vim-asterisk',
    event = 'BufRead',
  },
  {
    'tzachar/highlight-undo.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'uga-rosa/ccc.nvim',
    event = 'BufRead',
    opts = {
      -- see https://zenn.dev/uga_rosa/articles/61200f157b70fc
      highlighter = {
        auto_enable = true,
      },
    },
  },
  {
    'nacro90/numb.nvim',
    event = 'BufRead',
    opts = {
      show_numbers = true,
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      keywords = {
        TODO = {
          color = 'warning',
        },
      },
    },
  },
  {
    'AndrewRadev/linediff.vim',
    cmd = {
      'Linediff',
      'LinediffReset',
    },
  },
  {
    'yutkat/confirm-quit.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },
  {
    'dstein64/vim-startuptime',
    cmd = {
      'StartupTime',
    },
    init = function()
      vim.g.startuptime_tries = 100
    end,
  },
  {
    'senkentarou/csv-tools.nvim',
    ft = { 'csv', 'tsv', 'text', 'markdown' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}

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
    'monaqa/dial.nvim',
    event = 'BufRead',
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group{
        default = {
          augend.integer.alias.decimal,
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      }
    end,
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
}

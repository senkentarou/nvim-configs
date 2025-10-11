return {
  -- Plugin Manager
  {
    'folke/lazy.nvim',
  },

  -- Colorscheme
  {
    'w0ng/vim-hybrid',
    lazy = false,
    config = function()
      vim.api.nvim_exec('colorscheme hybrid', true)
    end,
  },

  -- Git Plugins
  {
    'senkentarou/gopr.nvim',
    cmd = {
      'Gocd',
      'Gopr',
    },
    opts = {
      default_remote = 'origin',
    },
  },
  {
    'senkentarou/gobf.nvim',
    cmd = {
      'Gobf',
      'Gobfop',
    },
    opts = {
      default_remote = 'origin',
      default_branches = {
        'main',
        'master',
        'develop',
      },
    },
  },
  {
    'senkentarou/goacf.nvim',
    cmd = { 'Goacf' },
  },

  -- LSP Plugins
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

  -- Parser & Editing Plugins
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup({
        chunk = {
          enable = false,
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '┌',
            left_bottom = '└',
            right_arrow = '─',
          },
          style = {
            '#73a5ff',
            '#f07882',
          },
          duration = 0,
          delay = 300,
        },
        indent = {
          enable = true,
          chars = {
            '│',
            '¦',
          },
        },
      })
    end,
  },
  {
    'machakann/vim-sandwich',
    event = 'BufRead',
  },
  {
    'haya14busa/vim-edgemotion',
    event = 'BufRead',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'NStefan002/visual-surround.nvim',
    event = 'BufRead',
    opts = {
      use_default_keymaps = false,
    },
  },

  -- Utility Plugins
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

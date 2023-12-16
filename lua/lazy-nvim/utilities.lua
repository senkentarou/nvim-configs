return {
  {
    'rainbowhxch/accelerated-jk.nvim',
    lazy = false,
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
    'kevinhwang91/nvim-hlslens',
    event = 'BufRead',
    config = function()
      require("scrollbar.handlers.search").setup({
        override_lens = function(render, posList, nearest, idx, _)
          local chunks = {
            {
              ('[%d/%d]'):format(idx, #posList),
              'HlSearchLens',
            },
          }
          local lnum, col = unpack(posList[idx])
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
      })
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    event = 'BufRead',
    opts = {
      handle = {
        blend = 0,
      },
      marks = {
        Cursor = {
          text = "◅",
        },
        Search = {
          color = '#f0c674',
        },
        Error = {
          color = '#ff0000',
        },
        Warn = {
          color = '#ffa500',
        },
        Info = {
          color = '#add8e6',
        },
        Hint = {
          color = '#d3d3d3',
        },
        GitAdd = {
          color = '#d7ffaf',
        },
        GitChange = {
          color = '#d7d7ff',
        },
        GitDelete = {
          color = '#cc6666',
        },
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      -- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
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
      local augend = require("dial.augend")
      require("dial.config").augends:register_group{
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
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-h>",
        },
      },
      filetypes = {
        ['*'] = false,
        ruby = true,
        rspec = true,
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        yaml = true,
        json = true,
        lua = true,
        markdown = true,
        text = true,
      },
    },
  },
  {
    'yutkat/confirm-quit.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 100
    end,
  },
}

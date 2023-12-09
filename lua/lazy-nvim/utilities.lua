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
    'AndrewRadev/linediff.vim',
    event = 'CmdlineEnter',
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

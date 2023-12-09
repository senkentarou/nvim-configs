require("ibl").setup {}

require('hop').setup {}

require('Comment').setup {}

require('treesj').setup {
  use_default_keymaps = false,
}

require('todo-comments').setup {
  -- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
  keywords = {
    TODO = {
      color = 'warning',
    },
  },
}

require('confirm-quit').setup {}

require('copilot').setup {
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
}

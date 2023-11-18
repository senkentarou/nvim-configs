require("ibl").setup {}

require('hop').setup {}

require('Comment').setup {}

require('todo-comments').setup {
  -- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
  keywords = {
    TODO = {
      color = 'warning',
    },
  },
}

require('confirm-quit').setup {}

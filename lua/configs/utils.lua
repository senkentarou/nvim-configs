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

require('rspec').setup {
  -- File format to allow rspec to run
  allowed_file_format = function(filename)
    return vim.endswith(filename, "_spec.rb")
  end,

  -- RSpec formatter. "progress", "p", "documentation" and "d" can be specified.
  -- If none of the above, use "progress".
  formatter = "progress",

  -- Whether or not to focus on a window when `RSpecShowLastResult` command executed.
  focus_on_last_spec_result_window = true,

  -- Whether or not to open the quickfix window when the spec fails.
  open_quickfix_when_spec_failed = true,

  -- File path to save the last spec result.
  last_result_path = vim.fn.stdpath("data") .. "/" .. "rspec_last_result",

  -- File path to save the last failed spec result.
  last_failed_result_path = vim.fn.stdpath("data") .. "/" .. "rspec_last_failed_result",

  -- Command to open the file to jump to.
  -- Examples of other alternatives: vsplit, split, tabedit
  jump_command = "edit",
}

require('confirm-quit').setup {}

local telescope = require("telescope")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local file_browser_actions = telescope.extensions.file_browser.actions

local open_multiple_files = function(bufnr)
  local picker = actions_state.get_current_picker(bufnr)
  local multi_sections = picker:get_multi_selection()
  actions.select_default(bufnr)
  for _, section in pairs(multi_sections) do
    if section.path ~= nil then -- is it a file -> open it as well:
      vim.cmd(string.format("%s %s", "edit", section.path))
    end
  end
end

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["<C-q>"] = actions.close,
        ["<CR>"] = open_multiple_files,
      },
      i = {
        ["<C-q>"] = actions.close,
        ["<Up>"] = actions.cycle_history_prev,
        ["<Down>"] = actions.cycle_history_next,
        ["<C-a>"] = { "<HOME>", type = "command" },
        ["<C-e>"] = { "<END>", type = "command" },
        ["<C-l>"] = function()
          vim.cmd ":norm! D"
        end,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-b>"] = actions.results_scrolling_up,
        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<CR>"] = open_multiple_files,
      },
    },
    color_devicons = true,
    set_env = {
      ["COLORTERM"] = "truecolor",
    },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
  },
  vimgrep_arguments = {
    "rg",
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--with-filename",
    "--trim",
  },
  pickers = {
    find_files = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob=!.git/",
      },
    },
    live_grep = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      glob_pattern = '!.git/',
      additional_args = function()
        return {
          '--hidden',
        }
      end,
    },
    grep_string = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      additional_args = function()
        return {
          '--hidden',
          "--glob=!.git/",
        }
      end,
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      path = "%:p:h",
      cwd = vim.fn.expand("%:p:h"),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      all_previewer = true,
      select_buffer = true,
      hide_parent_dir = true,
      mappings = {
        n = {
          ["<C-q>"] = actions.close,
          ["w"] = actions.which_key,
          ["r"] = file_browser_actions.rename,
          ["m"] = file_browser_actions.move, -- select file by tab and move target dir.
          ["c"] = file_browser_actions.copy,
          ["d"] = file_browser_actions.remove,
          ["n"] = file_browser_actions.create,
          ["h"] = file_browser_actions.goto_parent_dir,
          ["o"] = actions.select_default,
          ["l"] = actions.select_default,
          ["f"] = false,
        },
        i = {
          ["<C-q>"] = actions.close,
          ["<C-w>"] = actions.which_key,
          ["<C-r>"] = file_browser_actions.rename,
          ["<C-m>"] = file_browser_actions.move,
          ["<C-c>"] = file_browser_actions.copy,
          ["<C-d>"] = file_browser_actions.remove,
          ["<C-h>"] = file_browser_actions.goto_parent_dir,
          ["<C-o>"] = actions.select_default,
          ["<C-l>"] = actions.select_default,
        },
      },
    },
  },
}

telescope.load_extension('file_browser')
telescope.load_extension('gh_pr')
telescope.load_extension('git_log')
telescope.load_extension('convert_word_case')
telescope.load_extension('memo')

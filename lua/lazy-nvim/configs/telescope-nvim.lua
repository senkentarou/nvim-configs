local telescope = require("telescope")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local file_browser_actions = require('telescope._extensions.file_browser.actions')
local project_actions = require('telescope._extensions.project.actions')

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

local picker_config = {
  find_files = {
    base_command = {
      "rg",
      "--files",
      "--hidden",
      "--glob=!.git/",
    },
    additional_options = {
      "--glob=!spec/",
    },
    enable_options = false,
  },
  grep_string = {
    base_command = {
      "rg",
      "--column",
      "--line-number",
      "--no-heading",
      "--color=never",
      "--smart-case",
      "--with-filename",
      "--trim",
      "--hidden",
      "--glob=!.git/",
    },
    additional_options = {
      "--glob=!spec/",
    },
    enable_options = false,
  },
}

local find_files_command = function()
  local conf = picker_config.find_files
  local command = vim.deepcopy(conf.base_command)

  if conf.enable_options then
    table.insert(command, conf.additional_options)
  end

  return vim.tbl_flatten(command)
end

local grep_string_command = function()
  local conf = picker_config.grep_string
  local command = vim.deepcopy(conf.base_command)

  if conf.enable_options then
    table.insert(command, conf.additional_options)
  end

  -- need to add history before grep_string
  local latest_hist = vim.fn.histget('@', -1) or ''
  if latest_hist ~= '' then
    table.insert(command, {
      "--",
      latest_hist,
    })
  end

  return vim.tbl_flatten(command)
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
        ["<C-a>"] = {
          "<HOME>",
          type = "command",
        },
        ["<C-e>"] = {
          "<END>",
          type = "command",
        },
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
  vimgrep_arguments = picker_config.grep_string.base_command,
  pickers = {
    find_files = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      find_command = picker_config.find_files.base_command,
      mappings = {
        i = {
          -- toggle excludes by glob
          ["<C-r>"] = function(bufnr)
            picker_config.find_files.enable_options = not picker_config.find_files.enable_options

            local current_picker = actions_state.get_current_picker(bufnr)
            current_picker:refresh(finders.new_oneshot_job(find_files_command(), {
              entry_maker = make_entry.gen_from_file(),
            }))
          end,
        },
      },
    },
    grep_string = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      mappings = {
        i = {
          -- toggle excludes by glob
          ["<C-r>"] = function(bufnr)
            picker_config.grep_string.enable_options = not picker_config.grep_string.enable_options

            local current_picker = actions_state.get_current_picker(bufnr)
            current_picker:refresh(finders.new_oneshot_job(grep_string_command(), {
              entry_maker = make_entry.gen_from_vimgrep(),
            }))
          end,
        },
      },
    },
  },
  extensions = {
    project = {
      base_dirs = {
        '~/work',
        '~/mywork',
      },
      order_by = 'recent',
      search_by = 'title',
      -- default for on_project_selected = find project files
      on_project_selected = function(prompt_bufnr)
        project_actions.change_working_directory(prompt_bufnr, false)
      end,
    },
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
telescope.load_extension('git_log')
telescope.load_extension('convert_word_case')
telescope.load_extension('luasnip')
telescope.load_extension('project')

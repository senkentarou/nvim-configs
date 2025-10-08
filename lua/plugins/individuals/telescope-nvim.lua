local configs = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local actions_state = require('telescope.actions.state')
  local action_layout = require('telescope.actions.layout')
  local file_browser_actions = require('telescope._extensions.file_browser.actions')

  local open_multiple_files = function(bufnr)
    local picker = actions_state.get_current_picker(bufnr)
    local multi_sections = picker:get_multi_selection()

    -- set current to jumplist to enable comming back
    vim.api.nvim_command("normal! m'")

    actions.select_default(bufnr)
    for _, section in pairs(multi_sections) do
      if section.path ~= nil then -- is it a file -> open it as well:
        vim.api.nvim_exec(string.format('%s %s', 'edit', section.path), false)
      end
    end
  end

  local delete_buffer = function(bufnr)
    local current_picker = actions_state.get_current_picker(bufnr)
    local multi_sections = current_picker:get_multi_selection()

    -- Get the buffer to delete
    local target_bufnr
    if #multi_sections > 0 then
      target_bufnr = multi_sections[1].bufnr
    else
      local selection = actions_state.get_selected_entry()
      target_bufnr = selection and selection.bufnr
    end

    -- Count buffers shown in telescope picker
    local picker_entries = current_picker.manager:num_results()

    -- If this is the last buffer in telescope, close immediately
    if picker_entries <= 1 then
      actions.close(bufnr)
      if target_bufnr then
        vim.schedule(function()
          pcall(vim.api.nvim_buf_delete, target_bufnr, { force = false })
        end)
      end
      vim.notify('Only one buffer remaining', vim.log.levels.INFO)
      return
    end

    -- Use builtin delete_buffer action for normal cases
    actions.delete_buffer(bufnr)
  end

  local ff_base_cmd = {
    'rg',
    '--files',
    '--hidden',
    '--glob=!.git/',
  }

  local gs_base_cmd = {
    'rg',
    '--column',
    '--line-number',
    '--no-heading',
    '--color=never',
    '--smart-case',
    '--with-filename',
    '--trim',
    '--hidden',
    '--glob=!.git/',
  }

  local get_git_root = function()
    local result = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')
    if vim.v.shell_error == 0 and result[1] then
      return result[1]
    end
    return vim.fn.getcwd()
  end

  telescope.setup {
    defaults = {
      dynamic_preview_title = true,
      mappings = {
        n = {
          ['<C-q>'] = actions.close,
          ['<C-t>'] = action_layout.toggle_preview,
          ['<CR>'] = open_multiple_files,
        },
        i = {
          ['<C-q>'] = actions.close,
          ['<C-t>'] = action_layout.toggle_preview,
          ['<Up>'] = actions.cycle_history_prev,
          ['<Down>'] = actions.cycle_history_next,
          ['<C-a>'] = {
            '<HOME>',
            type = 'command',
          },
          ['<C-e>'] = {
            '<END>',
            type = 'command',
          },
          ['<C-l>'] = function()
            vim.api.nvim_exec(':norm! D', false)
          end,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-b>'] = actions.results_scrolling_up,
          ['<C-f>'] = actions.results_scrolling_down,
          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,
          ['<CR>'] = open_multiple_files,
        },
      },
      color_devicons = true,
      set_env = {
        ['COLORTERM'] = 'truecolor',
      },
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.95,
        height = 0.90,
        preview_cutoff = 120,
      },
    },
    pickers = {
      find_files = {
        cwd = get_git_root(),
        find_command = ff_base_cmd,
      },
      grep_string = {
        cwd = get_git_root(),
        vimgrep_arguments = gs_base_cmd,
        disable_coordinates = true,
      },
      live_grep = {
        cwd = get_git_root(),
        disable_coordinates = true,
      },
      buffers = {
        mappings = {
          n = {
            ['<C-c>'] = delete_buffer,
          },
          i = {
            ['<C-c>'] = delete_buffer,
          },
        },
      },
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
        path = '%:p:h',
        cwd = vim.fn.expand('%:p:h'),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        all_previewer = true,
        select_buffer = true,
        hide_parent_dir = true,
        mappings = {
          n = {
            ['<C-q>'] = actions.close,
            ['w'] = actions.which_key,
            ['r'] = file_browser_actions.rename,
            ['m'] = file_browser_actions.move, -- select file by tab and move target dir.
            ['c'] = file_browser_actions.copy,
            ['d'] = file_browser_actions.remove,
            ['n'] = file_browser_actions.create,
            ['h'] = file_browser_actions.goto_parent_dir,
            ['o'] = actions.select_default,
            ['l'] = actions.select_default,
            ['f'] = false,
          },
          i = {
            ['<C-q>'] = actions.close,
            ['<C-w>'] = actions.which_key,
            ['<C-r>'] = file_browser_actions.rename,
            ['<C-m>'] = file_browser_actions.move,
            ['<C-c>'] = file_browser_actions.copy,
            ['<C-d>'] = file_browser_actions.remove,
            ['<C-h>'] = file_browser_actions.goto_parent_dir,
            ['<C-o>'] = actions.select_default,
            ['<C-l>'] = actions.select_default,
          },
        },
      },
      psql_viewer = {
        database = {
          port = '45432',
          database = 'development',
        },
      },
    },
  }

  telescope.load_extension('file_browser')
  telescope.load_extension('git_log')
  telescope.load_extension('git_status')
  telescope.load_extension('convert_word_case')
  telescope.load_extension('copy_path')
  telescope.load_extension('psql_viewer')
end

return {
  -- NOTE: use for development setting.
  -- {
  --   dir = '~/path/to/your/local/extension',
  --   name = 'telescope-my-extension',
  --   dependencies = { 'nvim-telescope/telescope.nvim' },
  -- },
  -- NOTE: under construction
  -- {
  --   dir = '~/work/my/telescope-git-status.nvim',
  --   name = 'git_status',
  --   dependencies = { 'nvim-telescope/telescope.nvim' },
  -- },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'senkentarou/telescope-git-log.nvim',
      'senkentarou/telescope-git-status.nvim',
      'senkentarou/telescope-convert-word-case.nvim',
      'senkentarou/telescope-copy-path.nvim',
      'senkentarou/telescope-psql-viewer.nvim',
    },
    init = function()
      vim.api.nvim_create_autocmd({
        'VimEnter',
        'ColorScheme',
      }, {
        group = vim.api.nvim_create_augroup('MyTelescope', {
          clear = true,
        }),
        pattern = '*',
        command = 'highlight TelescopeMatching ctermfg=167 guifg=#cc6666',
      })
    end,
    cmd = {
      'Telescope',
    },
    config = configs,
  },
}

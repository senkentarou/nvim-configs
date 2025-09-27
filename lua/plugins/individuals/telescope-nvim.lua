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
    vim.cmd("normal! m'")

    actions.select_default(bufnr)
    for _, section in pairs(multi_sections) do
      if section.path ~= nil then -- is it a file -> open it as well:
        vim.api.nvim_exec(string.format('%s %s', 'edit', section.path), false)
      end
    end
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

  telescope.setup {
    defaults = {
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
        cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
        find_command = ff_base_cmd,
      },
      grep_string = {
        cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1],
        vimgrep_arguments = gs_base_cmd,
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
    },
  }

  telescope.load_extension('file_browser')
  telescope.load_extension('git_log')
  telescope.load_extension('git_status')
  telescope.load_extension('convert_word_case')
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'senkentarou/telescope-git-log.nvim',
      'senkentarou/telescope-git-status.nvim',
      'senkentarou/telescope-convert-word-case.nvim',
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

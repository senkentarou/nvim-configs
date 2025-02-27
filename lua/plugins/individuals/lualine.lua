local configs = function()
  local function lsp_client()
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return ' No Active Lsp'
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return ' ' .. client.name
      end
    end
    return ' No Filetype Lsp'
  end

  local function current_repository()
    return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  end

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'jellybeans',
      component_separators = {
        left = '',
        right = '',
      },
      section_separators = {
        left = '',
        right = '',
      },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        'mode',
      },
      lualine_b = {
        current_repository,
        'branch',
        {
          'diff',
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
        },
      },
      lualine_c = {
        {
          'filename',
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 1, -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as the home directory
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          symbols = {
            modified = '[+]', -- Text to show when the file is modified.
            readonly = '[RO]', -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]', -- Text to show for new created file before first writting
          },
        },
        lsp_client,
        {
          'diagnostics',
          sources = {
            'nvim_diagnostic',
          },
          sections = {
            'error',
            'warn',
            'info',
            'hint',
          },
        },
      },
      lualine_x = {
        'encoding',
        'filetype',
      },
      lualine_y = {
        'progress',
      },
      lualine_z = {
        'location',
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        'filename',
      },
      lualine_x = {
        'location',
      },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  }
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = configs,
  },
}

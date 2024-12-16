return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    init = function()
      vim.api.nvim_create_autocmd({
        'VimEnter',
        'ColorScheme',
      }, {
        group = vim.api.nvim_create_augroup('MyGitsigns', {
          clear = true,
        }),
        pattern = '*',
        command = 'highlight GitSignsCurrentLineBlame ctermfg=243 guifg=#707880',
      })
    end,
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
      }
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}

return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufRead',
    opts = {},
  },
  {
    'machakann/vim-sandwich',
    event = 'BufRead',
  },
  {
    'haya14busa/vim-edgemotion',
    event = 'BufRead',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'smoka7/hop.nvim',
    version = '*',
    init = function()
      vim.api.nvim_create_autocmd({
        "VimEnter",
        "ColorScheme",
      }, {
        group = vim.api.nvim_create_augroup("MyHop", {
          clear = true,
        }),
        pattern = "*",
        command = "highlight HopUnmatched cterm=underline ctermfg=242 gui=underline guifg=#666666 guisp=#666666",
      })
    end,
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    opts = {},
  },
}

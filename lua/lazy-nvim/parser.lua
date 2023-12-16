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
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    opts = {},
  },
}

return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('lazy-nvim.configs.alpha-nvim')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lazy-nvim.configs.lualine')
    end,
  },
  {
    'w0ng/vim-hybrid',
    lazy = false,
    config = function()
      vim.cmd([[ colorscheme hybrid ]])
    end,
  },
}

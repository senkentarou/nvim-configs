return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    dependencies = {
      'sifu/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
    },
    config = function()
      require('lazy-nvim.configs.nvim-treesitter')
    end,
  },
}

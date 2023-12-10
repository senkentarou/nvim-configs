return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-project.nvim',
      'benfowler/telescope-luasnip.nvim',
      'senkentarou/telescope-git-log.nvim',
      'senkentarou/telescope-convert-word-case.nvim',
    },
    cmd = {
      'Telescope',
    },
    config = function()
      require('lazy-nvim.configs.telescope-nvim')
    end,
  },

}

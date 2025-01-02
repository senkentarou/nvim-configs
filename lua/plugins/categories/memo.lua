return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ft = { 'markdown', 'aibou-markdown' },
    opts = {
      file_types = { 'markdown', 'aibou-markdown' },
    },
  },
}

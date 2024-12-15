return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    ft = { 'markdown', 'copilot-chat' },
    opts = {
      file_types = { 'markdown', 'copilot-chat' },
    },
  },
}

return {
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hlchunk').setup({
        chunk = {
          enable = false,
          chars = {
            horizontal_line = '─',
            vertical_line = '│',
            left_top = '┌',
            left_bottom = '└',
            right_arrow = '─',
          },
          style = {
            '#73a5ff',
            '#f07882',
          },
          duration = 0,
          delay = 300,
        },
        indent = {
          enable = true,
          chars = {
            '│',
            '¦',
          },
        },
      })
    end,
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
    'numToStr/Comment.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'NStefan002/visual-surround.nvim',
    event = 'BufRead',
    opts = {
      use_default_keymaps = false,
    },
  },
}

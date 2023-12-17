return {
  {
    'petertriho/nvim-scrollbar',
    event = 'BufRead',
    opts = {
      excluded_filetypes = {
        'alpha',
        'TelescopePrompt',
      },
      handle = {
        blend = 0,
      },
      marks = {
        Cursor = {
          text = "◅",
        },
        Search = {
          color = '#f0c674',
        },
        Error = {
          color = '#ff0000',
        },
        Warn = {
          color = '#ffa500',
        },
        Info = {
          color = '#add8e6',
        },
        Hint = {
          color = '#d3d3d3',
        },
        GitAdd = {
          color = '#d7ffaf',
        },
        GitChange = {
          color = '#d7d7ff',
        },
        GitDelete = {
          color = '#cc6666',
        },
      },
    },
  },
}

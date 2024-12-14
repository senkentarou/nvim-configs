return {
  {
    'senkentarou/gopr.nvim',
    cmd = {
      'Gocd',
      'Gopr',
    },
    opts = {
      default_remote = 'origin',
    },
  },
  {
    'senkentarou/gobf.nvim',
    cmd = {
      'Gobf',
      'Gobfop',
    },
    opts = {
      default_remote = 'origin',
      default_branches = {
        'main',
        'master',
        'develop',
      },
    },
  },
  {
    'senkentarou/goacf.nvim',
    cmd = { 'Goacf' },
  },
}

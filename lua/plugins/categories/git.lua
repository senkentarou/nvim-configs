return {
  {
    'senkentarou/gopr.nvim',
    cmd = {
      'Gocd',
      'Gopr',
    },
    opts = {
      default_remote = 'upstream',
    },
  },
  {
    'senkentarou/gobf.nvim',
    cmd = {
      'Gobf',
      'Gobfop',
    },
    opts = {
      default_remote = 'upstream',
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

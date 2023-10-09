require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
}

require('gopr').setup {
  default_remote = 'upstream',
}

require('gobf').setup {
  default_remote = 'upstream',
  default_branches = {
    'main',
    'master',
    'develop',
  },
}

require('neotest').setup {
  adapters = {
    require('neotest-rspec'),
  },
}

require('neotest-rspec') {
  rspec_cmd = function()
    return vim.tbl_flatten({
      'bundle',
      'exec',
      'rspec',
    })
  end,
}

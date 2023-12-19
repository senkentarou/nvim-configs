return {
  {
    'w0ng/vim-hybrid',
    lazy = false,
    config = function()
      vim.api.nvim_exec("colorscheme hybrid", true)
    end,
  },
}

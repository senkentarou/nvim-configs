return {
  {
    'kevinhwang91/nvim-hlslens',
    event = 'BufRead',
    init = function()
      vim.api.nvim_create_autocmd({
        'VimEnter',
        'ColorScheme',
      }, {
        group = vim.api.nvim_create_augroup('MyHlslens', {
          clear = true,
        }),
        pattern = '*',
        command = 'highlight HlSearchLens cterm=underline ctermfg=242 gui=underline guifg=#666666 guisp=#666666',
      })
    end,
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    config = function()
      require('scrollbar.handlers.search').setup({
        override_lens = function(render, posList, nearest, idx, _)
          local chunks = {
            {
              ('[%d/%d]'):format(idx, #posList),
              'HlSearchLens',
            },
          }
          local lnum, col = unpack(posList[idx])
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end,
      })
    end,
  },
}

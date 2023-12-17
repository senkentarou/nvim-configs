return {
  {
    'kevinhwang91/nvim-hlslens',
    event = 'BufRead',
    dependencies = {
      'petertriho/nvim-scrollbar',
    },
    config = function()
      require("scrollbar.handlers.search").setup({
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

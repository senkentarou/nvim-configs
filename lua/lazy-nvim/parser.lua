return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufRead',
    opts = {},
  },
  {
    'andersevenrud/nvim_context_vt',
    event = 'BufRead',
    opts = {
      -- see https://github.com/andersevenrud/nvim_context_vt
      prefix = '§',
      custom_parser = function(node, _, opts)
        -- If you return `nil`, no virtual text will be displayed.
        if node:type() == 'function' then
          return nil
        end

        -- see https://neovim.io/doc/user/treesitter.html#vim.treesitter.get_node_range()
        local start_row, _, _, _ = vim.treesitter.get_node_range(node)

        -- This is the standard text
        return opts.prefix .. ':' .. (start_row + 1)
      end,
    },
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
    'smoka7/hop.nvim',
    version = '*',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'Wansmer/treesj',
    opts = {
      use_default_keymaps = false,
    },
  },
}

return {
  -- plugin manager
  {
    'folke/lazy.nvim',
  },
  -- basics for editing
  {
    'w0ng/vim-hybrid',
    lazy = false,
    config = function()
      vim.cmd([[ colorscheme hybrid ]])
    end,
  },
  {
    'rainbowhxch/accelerated-jk.nvim',
    lazy = false,
  },
  {
    'kana/vim-smartword',
    event = 'BufRead',
  },
  -- advances for editing
  {
    'yutkat/confirm-quit.nvim',
    event = 'CmdlineEnter',
    opts = {},
  },
  -- dashboard
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function()
      require('configs.alpha-nvim')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('configs.lualine')
    end,
  },
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    dependencies = {
      'sifu/nvim-ts-autotag',
      'RRethy/nvim-treesitter-endwise',
      'andymass/vim-matchup',
    },
    config = function()
      require('configs.nvim-treesitter')
    end,
  },
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
    }
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
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'benfowler/telescope-luasnip.nvim',
      'senkentarou/telescope-git-log.nvim',
      'senkentarou/telescope-convert-word-case.nvim',
      -- memo
      'delphinus/telescope-memo.nvim',
      'glidenote/memolist.vim',
    },
    config = function()
      require('configs.telescope')
    end,
  },
  -- git integration
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    opts = {
      current_line_blame = true,
      current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
    },
  },
  {
    'senkentarou/gopr.nvim',
    event = 'BufRead',
    opts = {
      default_remote = 'upstream',
    },
  },
  {
    'senkentarou/gobf.nvim',
    event = 'BufRead',
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
    event = 'VimEnter',
  },
  -- lsp
  {
    'williamboman/mason.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'j-hui/fidget.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvimtools/none-ls.nvim',
      'jose-elias-alvarez/typescript.nvim',
    },
    config = function()
      require('configs.nvim-lspconfig')
    end,
  },
  {
    'Maan2003/lsp_lines.nvim',
    event = 'BufRead',
    opts = {},
  },
  {
    'aznhe21/actions-preview.nvim',
    opts = {
      -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
      diff = {
        algorithm = 'patience',
        ignore_whitespace = true,
      },
      backend = {
        'telescope',
      },
      telescope = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = 'top',
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
  },
  -- snippet
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'lukas-reineke/cmp-rg',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('configs.nvim-cmp')
    end,
  },
  -- utilities on development
  {
    'folke/todo-comments.nvim',
    event = 'BufRead',
    opts = {
      -- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
      keywords = {
        TODO = {
          color = 'warning',
        },
      },
    },
  },
  {
    'AndrewRadev/linediff.vim',
    event = 'CmdlineEnter',
  },
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-h>",
        },
      },
      filetypes = {
        ['*'] = false,
        ruby = true,
        rspec = true,
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        yaml = true,
        json = true,
        lua = true,
        markdown = true,
        text = true,
      },
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 100
    end,
  },
}

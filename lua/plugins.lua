--
-- Plugin settings
--
-- Before do :PlugInstall, download plug.vim
-- sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--
-- See details: https://github.com/junegunn/vim-plug
vim.cmd([[
  call plug#begin(stdpath('data') . '/plugged')

  " LSP
  Plug 'nvim-lua/plenary.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
  Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'folke/lsp-colors.nvim'
  Plug 'Maan2003/lsp_lines.nvim'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'onsails/lspkind.nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'roobert/action-hints.nvim'
  Plug 'aznhe21/actions-preview.nvim'
  Plug 'nvimtools/none-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  " Telescope
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'sheerun/vim-polyglot'
  Plug 'simrat39/symbols-outline.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v2.20.8' }
  Plug 'johmsalas/text-case.nvim'
  Plug 'machakann/vim-sandwich'
  Plug 'numToStr/Comment.nvim'
  Plug 'andersevenrud/nvim_context_vt'
  Plug 'phaazon/hop.nvim'
  Plug 'mfussenegger/nvim-treehopper'
  Plug 'kana/vim-smartword'
  Plug 'windwp/nvim-autopairs'
  Plug 'andymass/vim-matchup'
  Plug 'RRethy/nvim-treesitter-endwise'
  " Utilities
  Plug 'w0ng/vim-hybrid'
  Plug 'goolord/alpha-nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'rhysd/accelerated-jk'
  Plug 'haya14busa/vim-edgemotion'
  Plug 'folke/todo-comments.nvim'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'github/copilot.vim'
  Plug 'yutkat/confirm-quit.nvim'
  Plug 'mogulla3/rspec.nvim'

  "
  " My plugin
  "
  Plug 'senkentarou/gopr.nvim'
  Plug 'senkentarou/goacf.nvim'
  Plug 'senkentarou/gobf.nvim'
  Plug 'senkentarou/telescope-gh-pr.nvim'
  Plug 'senkentarou/telescope-git-log.nvim'

  "
  " Switch to original plugin!
  "
  " Plug 'lewis6991/gitsigns.nvim' " disable until https://github.com/lewis6991/gitsigns.nvim/issues/791 is as fixed
  Plug 'senkentarou/gitsigns.nvim' " Use instead of lewis6991/gitsigns.nvim

  " Plug 'nvim-telescope/telescope-file-browser.nvim' " disable until https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/104 is as fixed
  Plug 'senkentarou/telescope-file-browser.nvim' " Use instead of nvim-telescope/telescope-file-browser.nvim

  " Plug 'windwp/nvim-ts-autotag' " disable until https://github.com/windwp/nvim-ts-autotag/pull/83 is merged
  Plug 'sifu/nvim-ts-autotag' " Use instead of windwp/nvim-ts-autotag

  call plug#end()
]])

require('options')
require('keys')
require('configs')

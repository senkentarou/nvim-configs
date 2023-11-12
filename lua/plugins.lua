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
  Plug 'aznhe21/actions-preview.nvim'
  Plug 'nvimtools/none-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  " Telescope
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
  Plug 'nvim-telescope/telescope-live-grep-args.nvim'
  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'sheerun/vim-polyglot'
  Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v3.3.7' }
  Plug 'machakann/vim-sandwich'
  Plug 'numToStr/Comment.nvim'
  Plug 'andersevenrud/nvim_context_vt'
  Plug 'smoka7/hop.nvim'
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
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'github/copilot.vim'
  Plug 'yutkat/confirm-quit.nvim'
  Plug 'mogulla3/rspec.nvim'
  " Memo https://zenn.dev/koga1020/articles/009766e1bec42c
  Plug 'glidenote/memolist.vim'
  Plug 'delphinus/telescope-memo.nvim'

  "
  " My plugin
  "
  Plug 'senkentarou/gopr.nvim'
  Plug 'senkentarou/goacf.nvim'
  Plug 'senkentarou/gobf.nvim'
  Plug 'senkentarou/telescope-gh-pr.nvim'
  Plug 'senkentarou/telescope-git-log.nvim'
  Plug 'senkentarou/telescope-convert-word-case.nvim'

  "
  " Switch to original plugin!
  "
  " Plug 'nvim-telescope/telescope-file-browser.nvim' " disable until https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/104 is as fixed
  Plug 'senkentarou/telescope-file-browser.nvim' " Use instead of nvim-telescope/telescope-file-browser.nvim

  " Plug 'windwp/nvim-ts-autotag' " disable until https://github.com/windwp/nvim-ts-autotag/pull/83 is merged
  Plug 'sifu/nvim-ts-autotag' " Use instead of windwp/nvim-ts-autotag

  call plug#end()
]])

require('options')
require('keys')
require('configs')

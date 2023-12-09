--
-- Load
--
if vim.loader then
  vim.loader.enable()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- plugin manager
  { 'folke/lazy.nvim' },
  -- nvim enhancement
  { 'nvim-lua/plenary.nvim' },
  -- basics for editing
  { 'w0ng/vim-hybrid' },
  { 'rhysd/accelerated-jk' },
  { 'kana/vim-smartword' },
  -- advances for editing
  { 'yutkat/confirm-quit.nvim' },
  -- dashboard
  { 'nvim-tree/nvim-web-devicons' },
  { 'goolord/alpha-nvim' },
  { 'nvim-lualine/lualine.nvim' },
  -- treesitter
  { 'nvim-treesitter/nvim-treesitter' },
  { 'sheerun/vim-polyglot' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'andersevenrud/nvim_context_vt' },
  { 'RRethy/nvim-treesitter-endwise' },
  { 'machakann/vim-sandwich' },
  { 'windwp/nvim-autopairs' },
  { 'andymass/vim-matchup' },
  { 'smoka7/hop.nvim' },
  { 'haya14busa/vim-edgemotion' },
  { 'numToStr/Comment.nvim' },
  { 'Wansmer/treesj' },
  { 'sifu/nvim-ts-autotag' },
  -- telescope
  { 'nvim-telescope/telescope.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'benfowler/telescope-luasnip.nvim' },
  { 'senkentarou/telescope-git-log.nvim' },
  -- git integration
  { 'lewis6991/gitsigns.nvim' },
  { 'senkentarou/gopr.nvim' },
  { 'senkentarou/goacf.nvim' },
  { 'senkentarou/gobf.nvim' },
  -- lsp
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  { 'j-hui/fidget.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'folke/lsp-colors.nvim' },
  { 'Maan2003/lsp_lines.nvim' },
  { 'aznhe21/actions-preview.nvim' },
  { 'nvimtools/none-ls.nvim' },
  { 'jose-elias-alvarez/typescript.nvim' },
  -- snippet
  { 'rafamadriz/friendly-snippets' },
  { 'onsails/lspkind.nvim' },
  { 'L3MON4D3/LuaSnip' },
  { 'lukas-reineke/cmp-rg' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },
  -- utilities on development
  { 'folke/todo-comments.nvim' },
  { 'AndrewRadev/linediff.vim' },
  { 'zbirenbaum/copilot.lua' },
  { 'senkentarou/telescope-convert-word-case.nvim' },
  -- memo
  { 'glidenote/memolist.vim' },
  { 'delphinus/telescope-memo.nvim' },
}

require("lazy").setup(plugins)

require('options')
require('keys')
require('configs')

if not vim.g.vscode then
  require('lazy-init')
  require('core.options')
  require('core.keymaps')
  require('core.autocmds')
else
  -- for VSCode Neovim extension
  vim.opt.clipboard = 'unnamedplus'
end

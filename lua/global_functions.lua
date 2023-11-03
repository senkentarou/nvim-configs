local G = {}

G.toggle_lsp_lines_text = function()
  local flag = vim.diagnostic.config().virtual_lines
  local toggled_flag = not flag

  vim.diagnostic.config({
    virtual_lines = toggled_flag,
    virtual_text = flag,
  })
end

G.move_to_start_context = function()
  -- see https://neovim.io/doc/user/treesitter.html#TSNode%3Astart()
  local row, _, _ = vim.treesitter.get_node():start()
  vim.api.nvim_command(':' .. (row + 1))
end

G.close_buffer = function()
  local filetype = vim.bo.filetype
  local command = ''

  if filetype == 'alpha' then
    -- no action
    command = ':'
  elseif vim.fn.index({
    'help',
    'vim-plug',
    'lspinfo',
    'nvim-docs-view',
  }, filetype) >= 0 then
    -- close pane
    command = 'close'
  elseif vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)')[2] ~= nil then
    -- close buffer
    command = 'bd'
  else
    -- default open goolord/alpha-nvim
    command = 'Alpha'
  end

  vim.api.nvim_command(command)
end

G.cword_as_input = function()
  -- add cword into input history
  -- :history @, if you want to see history
  local cword = vim.fn.expand("<cword>")
  vim.fn.histadd('@', cword)
  return cword
end

return G

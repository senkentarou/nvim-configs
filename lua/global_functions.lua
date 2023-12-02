local G = {}

local context_node = function()
  -- see https://neovim.io/doc/user/treesitter.html#treesitter-node
  -- and context taegets: https://github.com/andersevenrud/nvim_context_vt/blob/a14f9292b4bd68ceed433fc513f287641816dc6d/lua/nvim_context_vt/config.lua#L17
  local targets = require('nvim_context_vt.config').targets

  local node = vim.treesitter.get_node()
  while node ~= nil and not vim.tbl_contains(targets, node:type()) do
    node = node:parent()
  end

  return node
end

G.start_memo = function()
  -- date: 2023-11-11 00:00:00
  -- tags: [2023 11]
  -- categories: [memo]
  local date = vim.fn.strftime("%Y-%m-%d_%H-%M-%S")
  local year, month, _ = unpack(vim.split(vim.split(date, '_')[1], '-'))

  vim.api.nvim_command('MemoNewWithMeta \'' .. date .. '\', \'' .. year .. ' ' .. month .. '\', \'memo\'')
end

G.toggle_lsp_lines_text = function()
  local flag = vim.diagnostic.config().virtual_lines
  local toggled_flag = not flag

  vim.diagnostic.config({
    virtual_lines = toggled_flag,
    virtual_text = flag,
  })
end

G.move_to_context = function(opt)
  opt = opt or {}

  local node = context_node()

  if node == nil then
    vim.notify('no target node to move')
    return
  end

  local row, col

  if opt.start then
    row, col, _ = node:start()
  elseif opt.end_ then
    row, col, _ = node:end_()
  else
    vim.notify('no target option to move: start or end_')
    return
  end

  vim.api.nvim_command(':' .. (row + 1) .. 'norm' .. (col + 1) .. '|')
end

G.toggle_rspec_file = function()
  local current_file = vim.fn.expand('%:t')

  if not string.match(current_file, "%.rb$") then
    vim.notify('current file is not .rb file.')
    return
  end

  local current_dir = vim.fn.expand('%:h')
  local target_dir = nil
  local target_file = nil

  if string.match(current_dir, "^spec/") then
    -- On "spec/" directory, "requests" directory files should be open as "controller.rb" file.
    -- The other files should be opend as it by target: ruby file is under "app" directory or not
    if string.match(current_dir, "/requests") then
      target_dir = string.gsub(current_dir, '^spec/requests', 'app/controllers')
      target_file = string.gsub(current_file, '_spec%.rb$', '_controller.rb')
    else
      target_dir = string.gsub(current_dir, '^spec/?(.*)', '%1')
      -- Check "app/" directory contents
      if vim.fn.isdirectory('app/' .. target_dir) > 0 then
        target_dir = 'app/' .. target_dir
      end

      target_file = string.gsub(current_file, '_spec%.rb$', '.rb')
    end
  elseif string.match(current_dir, "^app/") then
    -- On "app/" directory, "controller.rb" file should be opend as "request" spec.
    -- The other files should be opend as it under the "spec" directory.
    if string.match(current_dir, "/controllers") and string.match(current_file, "_controller%.rb$") then
      target_dir = string.gsub(current_dir, 'app/controllers', 'spec/requests')
      target_file = string.gsub(current_file, '_controller%.rb$', '_spec.rb')
    else
      -- replace base directory to "spec".
      target_dir = string.gsub(current_dir, '^app/', 'spec/')
      target_file = string.gsub(current_file, '%.rb$', '_spec.rb')
    end
  else
    -- On the other directory, it should be opend on "/spec" directory and "spec.rb" file.
    target_dir = 'spec/' .. current_dir
    target_file = string.gsub(current_file, '%.rb$', '_spec.rb')
  end

  if target_dir and target_file then
    vim.fn.mkdir(target_dir, 'p')
    vim.api.nvim_command('e ' .. target_dir .. '/' .. target_file)
  else
    vim.notify('could not open ' .. target_dir .. '/' .. target_file, vim.log.levels.ERROR)
  end
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

G.histadd_string = function(input)
  -- add input into history
  -- :history @, if you want to see history
  vim.fn.histadd('@', input)
  return input
end

return G

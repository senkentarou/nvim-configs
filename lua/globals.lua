local G = {}

G.toggle_hlsearch = function()
  if vim.v.hlsearch == 0 then
    vim.api.nvim_command('set hlsearch')
  else
    vim.api.nvim_command('set nohlsearch')
  end
end

G.toggle_lsp_lines_text = function()
  local flag = vim.diagnostic.config().virtual_lines
  local toggled_flag = not flag

  vim.diagnostic.config({
    virtual_lines = toggled_flag,
    virtual_text = flag,
  })
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

G.histadd_string = function(input)
  -- add input into history
  -- :history @, if you want to see history
  vim.fn.histadd('@', input)
  return input
end

G.hop_with_char = function(opts)
  opts = opts or {}

  local direction

  if opts.direction == 'before_cursor' then
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR
  elseif opts.direction == 'after_cursor' then
    direction = require('hop.hint').HintDirection.AFTER_CURSOR
  end

  require('hop').hint_patterns({
    direction = direction,
    current_line_only = (opts.current_line_only == true),
  }, vim.fn.escape(vim.fn.getcharstr(), '\\/.$^~[]'))
end

G.pagedown = function()
  -- ref. https://zenn.dev/vim_jp/articles/20240522_ekiden_better_hl
  local line = vim.fn.line('.')
  vim.api.nvim_command('normal! L')

  -- page down if the cursor is on the last page
  if line == vim.fn.line('.') then
    vim.api.nvim_command('normal! ztL')
  end

  if vim.fn.line('.') == vim.fn.line('$') then
    vim.api.nvim_command('normal! z-')
  end

  vim.api.nvim_command('normal! 0')
end

return G

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
  local is_virtual_text = flag == true
  local toggled_flag = not flag

  vim.diagnostic.config({
    virtual_lines = toggled_flag,
    virtual_text = is_virtual_text,
  })
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

G.pageup = function()
  -- ref. https://zenn.dev/vim_jp/articles/20240522_ekiden_better_hl
  local line = vim.fn.line('.')
  local topline = vim.fn.winsaveview().topline

  vim.api.nvim_command('normal! H')

  -- page up if the cursor is on the first of page
  if line == vim.fn.line('.') then
    vim.api.nvim_command('normal! zbH')
  end

  local newtopline = vim.fn.winsaveview().topline
  if newtopline == 1 and newtopline ~= topline then
    vim.api.nvim_exec(tostring(line), false)
  end

  vim.api.nvim_command('normal! 0')
end

G.pagedown = function()
  -- ref. https://zenn.dev/vim_jp/articles/20240522_ekiden_better_hl
  local line = vim.fn.line('.')
  local topline = vim.fn.winsaveview().topline

  vim.api.nvim_command('normal! L')

  -- page down if the cursor is on the last of page
  if line == vim.fn.line('.') then
    vim.api.nvim_command('normal! ztL')
  end

  if vim.fn.line('.') == vim.fn.line('$') then
    vim.api.nvim_command('normal! z-')

    if topline ~= vim.fn.winsaveview().topline then
      vim.api.nvim_exec(tostring(line), false)
    end
  end

  vim.api.nvim_command('normal! 0')
end

G.close_buffer = function()
  local filetype = vim.bo.filetype

  if filetype == 'alpha' then
    return
  end

  -- add jumplist before close
  vim.api.nvim_command("normal! m'")

  local close_filetypes = {
    'help',
    'lspinfo',
    'lazy',
    'startuptime',
    'aibou-markdown',
  }

  local cmd = ''
  if vim.fn.index(close_filetypes, filetype) >= 0 then
    cmd = 'close'
  elseif vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)')[2] ~= nil then
    cmd = 'bd'
  else
    -- command to last buffer
    cmd = 'Alpha'
  end

  vim.api.nvim_command(cmd)
end

G.toggle_memo = function()
  local memo_path = vim.fn.expand('~/.local/share/memo.md')
  if vim.fn.expand('%:p') == memo_path then
    -- close memo without adding jumplist
    local cmd

    if vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)')[2] ~= nil then
      cmd = 'bd'
    else
      -- command to last buffer
      cmd = 'Alpha'
    end

    vim.api.nvim_command(cmd)

    return
  end

  -- open memo
  vim.api.nvim_command('e ' .. memo_path)

  vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(0, 'swapfile', false)

  -- auto save
  vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'BufLeave' }, { buffer = 0, command = 'silent update' })
end

G.open_in_vscode = function()
  local current_file = vim.fn.expand('%:p')

  -- check if current buffer has a file
  if current_file == '' then
    vim.notify('No file to open in VSCode', vim.log.levels.WARN)
    return
  end

  -- open file in VSCode asynchronously
  vim.system({ 'code', current_file }, { detach = true }, function(obj)
    if obj.code == 0 then
      vim.schedule(function()
        vim.notify('Opened ' .. vim.fn.fnamemodify(current_file, ':t') .. ' in VSCode', vim.log.levels.INFO)
      end)
    else
      vim.schedule(function()
        vim.notify('Failed to open VSCode', vim.log.levels.ERROR)
      end)
    end
  end)
end

return G

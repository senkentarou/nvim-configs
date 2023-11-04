local G = {}

-- TODO: wants to as plugin
G.convert_word = function(opts)
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local previewers = require('telescope.previewers')
  local config = require('telescope.config').values

  local function convert(word, condition)
    if condition == 'snake_case' then
      return word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
    elseif condition == 'camelCase' then
      return word:gsub('(_)([a-z])', function(_, l)
        return l:upper()
      end)
    elseif condition == 'UPPER_SNAKE_CASE' then
      return word:gsub('([a-z])([A-Z])', '%1_%2'):upper()
    elseif condition == 'UpperCamelCase' then
      local camel = word:gsub('(_)([a-z])', function(_, l)
        return l:upper()
      end)
      return camel:gsub('^([a-z])', function(l)
        return l:upper()
      end)
    elseif condition == 'lower-chain-case' then
      local snake = word:gsub('([a-z])([A-Z])', '%1_%2'):lower()
      return snake:gsub('([a-z])_([a-z])', '%1-%2')
    end

    vim.notify('cannot convert.')
  end

  opts = opts or {}
  opts.bufnr = vim.fn.bufnr()
  opts.current_line = vim.fn.line('.')
  opts.current_word = vim.fn.expand("<cword>")

  if not opts.current_word:find('[a-zA-Z_]') then
    vim.notify('no convert case: ' .. opts.current_word)
    return
  end

  pickers.new(opts, {
    prompt_title = 'case "' .. opts.current_word .. '"',
    results_title = 'convert actions',
    finder = finders.new_table {
      results = {
        {
          'convert to snake_case',
          'snake_case',
        },
        {
          'convert to camelCase',
          'camelCase',
        },
        {
          'convert to UPPER_SNAKE_CASE',
          'UPPER_SNAKE_CASE',
        },
        {
          'convert to UpperCamelCase',
          'UpperCamelCase',
        },
        {
          'convert to lower-chain-case',
          'lower-chain-case',
        },
      },
      entry_maker = function(entry)
        local display = entry[1]
        local condition = entry[2]

        local converted_word = convert(opts.current_word, condition)
        if opts.current_word == converted_word then
          return
        end

        return {
          value = entry,
          display = display,
          ordinal = display,
          opts = {
            condition = condition,
            converted_word = converted_word,
          },
        }
      end,
    },
    previewer = previewers.new_buffer_previewer({
      title = 'case preview',
      define_preview = function(self, entry, _)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
          opts.current_word .. '  ' .. entry.opts.converted_word,
        })
      end,
    }),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<C-r>", function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local converted_word = convert(opts.current_word, selection.opts.condition)

        if opts.current_word == converted_word then
          return
        end

        -- replace by vim.lsp
        local params = vim.lsp.util.make_position_params()
        params.newName = converted_word
        vim.lsp.buf_request(0, 'textDocument/rename', params)
      end)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local converted_word = convert(opts.current_word, selection.opts.condition)

        if opts.current_word == converted_word then
          return
        end

        -- search word only current line
        -- https://vimhelp.org/builtin.txt.html#searchpos%28%29
        local row_pos, col_pos = unpack(vim.fn.searchpos(opts.current_word, 'bcn', opts.current_line))

        if row_pos == 0 or col_pos == 0 then
          return
        end

        -- replace word
        vim.api.nvim_buf_set_text(0, row_pos - 1, col_pos - 1, row_pos - 1, col_pos - 1 + #opts.current_word, {
          converted_word,
        })
      end)

      return true
    end,
  }):find()
end

G.toggle_lsp_lines_text = function()
  local flag = vim.diagnostic.config().virtual_lines
  local toggled_flag = not flag

  vim.diagnostic.config({
    virtual_lines = toggled_flag,
    virtual_text = flag,
  })
end

G.move_to_start_context = function()
  -- see https://neovim.io/doc/user/treesitter.html#treesitter-node
  -- and context taegets: https://github.com/andersevenrud/nvim_context_vt/blob/a14f9292b4bd68ceed433fc513f287641816dc6d/lua/nvim_context_vt/config.lua#L17
  local targets = require('nvim_context_vt.config').targets

  local node = vim.treesitter.get_node()
  while node ~= nil and not vim.tbl_contains(targets, node:type()) do
    node = node:parent()
  end

  if node == nil then
    vim.notify('no target to move')
    return
  end

  local row, col, _ = node:start()

  vim.api.nvim_command(':' .. (row + 1) .. 'norm' .. (col + 1) .. '|')
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

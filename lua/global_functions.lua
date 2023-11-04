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
    end

    vim.notify('cannot convert.')
  end

  opts = opts or {}
  opts.bufnr = vim.fn.bufnr()
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
          'convert to camelCase',
          'camelCase',
        },
        {
          'convert to snake_case',
          'snake_case',
        },
      },
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1],
          ordinal = entry[1],
          opts = {
            condition = entry[2],
          },
        }
      end,
    },
    previewer = previewers.new_buffer_previewer({
      title = 'case preview',
      define_preview = function(self, entry, _)
        local converted_word = convert(opts.current_word, entry.opts.condition)

        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
          opts.current_word .. '  ' .. converted_word,
        })
      end,
    }),
    sorter = config.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()
        local converted_word = convert(opts.current_word, selection.opts.condition)

        if opts.current_word == converted_word then
          return
        end

        -- move word start
        -- https://vimhelp.org/builtin.txt.html#searchpos%28%29
        local row_pos, col_pos = unpack(vim.fn.searchpos(opts.current_word, 'bcn'))

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

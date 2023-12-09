--
-- Vim options
--
vim.opt.mouse = ""
vim.opt.undofile = true
vim.opt.cmdheight = 2
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.termguicolors = true
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.backspace = [[indent,eol,start]]
vim.opt.wrap = true
vim.opt.whichwrap = [[b,s,<,>,[,],h,l]]
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamed'
vim.opt.completeopt = [[menuone,noinsert,noselect]]
vim.opt.shortmess:append({
  c = true,
})
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

local ns = vim.api.nvim_create_namespace('toggle_hlsearch')
local function toggle_hlsearch(char)
  if vim.fn.mode() == 'n' then
    local keys = {
      '<CR>',
      'n',
      'N',
      '*',
      '#',
      '?',
      '/',
    }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end
vim.on_key(toggle_hlsearch, ns)

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = true,
  virtual_lines = false,
})

vim.g.memolist_filename_prefix_none = 1
vim.g.memolist_memo_date = "%Y-%m-%d %H:%M:%S"
vim.g.memolist_path = "~/.memolist/memo"
vim.g.memolist_memo_suffix = "md"
vim.g.memolist_fzf = 1
vim.g.memolist_template_dir_path = "~/.memolist/memotemplates"

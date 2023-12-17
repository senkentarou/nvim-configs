return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    init = function()
      vim.api.nvim_create_autocmd({
        "VimEnter",
        "ColorScheme",
      }, {
        group = vim.api.nvim_create_augroup("MyCopilot", {
          clear = true,
        }),
        pattern = "*",
        command = "highlight CopilotSuggestion cterm=underline ctermfg=139 ctermbg=53 gui=underline guifg=#b294bb guibg=#5f005f guisp=Magenta",
      })
    end,
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          accept_word = false,
          accept_line = false,
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-h>",
        },
      },
      filetypes = {
        ['*'] = false,
        ruby = true,
        rspec = true,
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
        yaml = true,
        json = true,
        lua = true,
        markdown = true,
        text = true,
      },
    },
  },
}

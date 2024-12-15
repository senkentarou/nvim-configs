local function generate_prompts(select)
  return {
    Explain = {
      prompt = "/COPILOT_EXPLAIN アクティブな選択範囲にあるコードの説明を段落形式で書いてください。",
    },
    Review = {
      prompt = "/COPILOT_REVIEW アクティブな選択範囲にあるコードをベテランエンジニアの視点でレビューしてください。コード部分以外は日本語で解説してください。",
    },
    Fix = {
      prompt = "/COPILOT_GENERATE このコードには問題があります。バグを修正したコードに書き直してください。",
    },
    Optimize = {
      prompt = "/COPILOT_GENERATE 明瞭性と可読性を向上させるために、次のコードをリファクタリングしてください。",
    },
    Docs = {
      prompt = "/COPILOT_GENERATE 選択範囲について後から見た人が理解できる内容のドキュメントコメントを生成してください。",
    },
    Tests = {
      prompt = "/COPILOT_GENERATE 単体テストを生成してください。",
    },
    FixDiagnostic = {
      prompt = "ファイル内の次のエラーを解決するように支援してください:",
      selection = select.diagnostics,
    },
  }
end

return {
  {
    'zbirenbaum/copilot.lua',
    event = 'BufRead',
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
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    cmd = 'CopilotChat',
    dependencies = {
      'zbirenbaum/copilot.lua',
    },
    opts = function()
      local select = require('CopilotChat.select')
      return {
        model = 'gpt-4o',
        show_help = true,
        question_header = '  User ',
        answer_header = '  Copilot ',
        selection = function(source)
          return select.visual(source) or select.buffer(source)
        end,
        prompts = generate_prompts(select),
        window = {
          width = 0.4,
        },
        mappings = {
          close = {
            normal = '<C-q>',
            insert = '<C-q>',
          },
          reset = {
            normal = '<C-k>',
            insert = '<C-k>',
          },
        },
      }
    end,
  },
}

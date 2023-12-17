local configs = function()
  local alpha = require('alpha')
  local dashboard = require('alpha.themes.startify')

  dashboard.section.header.val = {} -- clear header art
  dashboard.section.top_buttons.val = {} -- clear header art
  dashboard.section.mru.val = {}
  dashboard.section.bottom_buttons.val = {
    {
      type = "text",
      val = "Shortcuts",
      opts = {
        hl = "SpecialComment",
      },
    },
    {
      type = "padding",
      val = 1,
    },
    dashboard.button("e", " New File", "<cmd>ene<CR>"),
    dashboard.button("t", " Telescope Builtins", "<cmd>Telescope<CR>"),
    dashboard.button("l", " Show Plugins", "<cmd>Lazy<CR>"),
    dashboard.button("p", "󰚰 Update Plugins", "<cmd>Lazy sync<CR>"),
    {
      type = "padding",
      val = 1,
    },
    dashboard.button("q", " Exit", "<cmd>qa<CR>"),
  }
  dashboard.section.footer.val = {}

  alpha.setup(dashboard.config)
end

return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = configs,
  },
}

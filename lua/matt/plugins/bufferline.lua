return {
  'akinsho/bufferline.nvim',
  after = 'catppuccin',
  config = function()
    local macchiato = require('catppuccin.palettes').get_palette 'macchiato'
    require('bufferline').setup {
      highlights = require('catppuccin.groups.integrations.bufferline').get_theme {
        styles = { 'italic', 'bold' },
        custom = {
          macchiato = {
            fill = { bg = macchiato.surface0 },
            background = { bg = macchiato.surface0 },
          },
        },
      },
    }
  end,
  -- ---@module 'bufferline'
  -- ---@type bufferline.Config
  -- opts = {
  --   options = {
  --     always_show_bufferline = true,
  --     separator_style = 'thick',
  --     hover = {
  --       enabled = true,
  --       delay = 120,
  --       reveal = { 'close' },
  --     },
  --   },
  -- },
}

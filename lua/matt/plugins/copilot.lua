return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  config = function()
    require('copilot').setup {
      panel = {
        keymap = {
          accept = "<S-Tab>"
        }
      }
    }
  end,
}

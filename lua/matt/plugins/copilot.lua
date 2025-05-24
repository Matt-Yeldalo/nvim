return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  config = function()
    require('copilot').setup {
      auth_provider_url = 'https://busways.ghe.com/',
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  end,
}

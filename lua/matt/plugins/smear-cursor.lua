return {
  'smear-cursor.nvim',
  event = 'VeryLazy',
  config = function()
    require('smear-cursor').setup {
      cursor = {
        enabled = true,
        type = 'horizontal',
        width = 2,
      },
      highlight = {
        enabled = true,
        duration = 1000,
      },
    }
  end,
}

-- require('matt.themes.arcoiris')
-- vim.cmd('colorscheme arcoiris')

local theme = 'olimorris/onedarkpro.nvim'
local mod = 'onedarkpro'
local scheme = 'onedark_vivid'

-- local theme = 'navarasu/onedark.nvim'
-- local mod = 'onedark'
-- local preset = 'warmer'

return {
  theme,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme onedark')
  end
}

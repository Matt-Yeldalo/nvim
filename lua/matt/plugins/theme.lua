local theme = 'olimorris/onedarkpro.nvim'
local mod = 'onedarkpro'
local scheme = 'onedark'


return {
  theme,
  priority = 1000,
  config = function()
    vim.cmd('colorscheme onedark_dark')
  end
}

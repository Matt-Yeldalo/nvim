local theme = 'olimorris/onedarkpro.nvim'
local mod = 'onedarkpro'
local scheme = 'onedark_vivid'

return {
  theme,
  priority = 1000,
  config = function()
    require(mod).setup {
    }
    vim.cmd('colorscheme ' .. scheme)
  end,
}

local theme = 'rebelot/kanagawa.nvim'
local mod = 'kanagawa'
local scheme = 'kanagawa'

return {
  theme,
  priority = 1000,
  config = function()
    require(mod).setup {
      dimInactive = true,
      background = {
        dark = "wave" -- wave | dragon
      }
    }
    vim.cmd('colorscheme ' .. scheme)
  end,
}

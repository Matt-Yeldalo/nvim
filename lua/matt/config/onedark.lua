local scheme = 'onedark'
local trans = false

return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'deep', -- deep = dark + clear contrast
      transparent = trans,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,

      toggle_style_key = '<leader>ot',
      toggle_style_list = { 'dark', 'darker', 'cool', 'warm', 'warmer', 'deep', 'light' },

      -- Code style optimized for readability
      code_style = {
        comments = 'italic',
        keywords = 'bold', -- bold instead of italic for clearer reading
        functions = 'bold',
        strings = 'none',
        variables = 'none',
      },

      lualine = { transparent = trans },
      diagnostics = { darker = true, undercurl = true, background = true },

      -- Adjusted, high-contrast palette
      colors = {
        green  = '#a3d38b', -- subtle, softer green
        purple = '#c291f4', -- readable soft-magenta
        cyan   = '#63d3e3', -- brighter cyan
        blue   = '#61afef', -- classic readable blue
        yellow = '#ffd97a', -- slightly brighter yellow for strings
        red    = '#ff6c75', -- vivid but readable red
        orange = '#d19a66',
      },

      highlights = {
        -- Keywords: bold soft-magenta
        ['@keyword'] = { fg = '$purple', style = 'bold' },
        -- Return, break, continue stand out
        ['@keyword.return'] = { fg = '$purple', style = 'bold,underline' },
        -- Imports/includes: bold blue
        ['@include'] = { fg = '$blue', style = 'bold' },
        -- Functions and methods: bold bright blue
        ['@function'] = { fg = '$blue', style = 'bold' },
        ['@function.call'] = { fg = '$blue', style = 'bold' },
        -- Variables: normal fg, so they don’t distract
        ['@variable'] = { fg = '$fg' },
        -- Strings: bright yellow for clarity
        ['@string'] = { fg = '$yellow' },
        -- Constants & numbers: cyan pop
        ['@constant'] = { fg = '$cyan', style = 'bold' },
        ['@number'] = { fg = '$cyan' },
        ['@type'] = { fg = '$cyan', style = 'bold' },
      },
    }

    vim.cmd('colorscheme ' .. scheme)
  end,
}


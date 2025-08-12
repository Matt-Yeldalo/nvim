local scheme = 'onedark'
local trans = false

return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').setup {
      style = 'darker',
      transparent = trans,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,

      toggle_style_key = '<leader>ot',
      toggle_style_list = { 'dark', 'darker', 'cool', 'warm', 'warmer', 'deep', 'light' },

      code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'bold',
        strings = 'none',
        variables = 'none',
      },

      lualine = { transparent = trans },
      diagnostics = { darker = true, undercurl = true, background = true },

      colors = {
        green = '#a3d38b',
        purple = '#c291f4',
        cyan = '#63d3e3',
        blue = '#61afef',
        yellow = '#ffd97a',
        red = '#ff6c75',
        orange = '#d19a66',
      },

      highlights = {
        -- Core keywords & flow control
        ['@keyword'] = { fg = '$purple', style = 'bold' },
        ['@keyword.return'] = { fg = '$purple', style = 'bold,underline' },

        -- Functions and methods
        ['@function'] = { fg = '$blue', style = 'bold' },
        ['@function.call'] = { fg = '$blue', style = 'bold' },

        -- Strings & Symbols (differentiate!)
        ['@string'] = { fg = '$yellow' }, -- "someClass"
        ['@string.special'] = { fg = '$orange' }, -- e.g., escaped chars
        ['@symbol'] = { fg = '$purple', style = 'bold' }, -- :full_name

        -- Constants, numbers, and booleans
        ['@constant'] = { fg = '$cyan', style = 'bold' },
        ['@number'] = { fg = '$cyan' },
        ['@boolean'] = { fg = '$cyan', style = 'bold' },

        -- HTML / XML / JSX
        ['@tag'] = { fg = '$blue', style = 'bold' },
        ['@tag.attribute'] = { fg = '$green' }, -- class=, id=, etc
        ['@tag.delimiter'] = { fg = '$fg' }, -- <, >

        -- Variables & fields
        ['@variable'] = { fg = '$fg' },
        ['@field'] = { fg = '$cyan' },
        ['@property'] = { fg = '$cyan' },
      },
    }

    vim.cmd('colorscheme ' .. scheme)
  end,
}

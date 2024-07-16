return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim"
  },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>tf', builtin.find_files, {desc = "Find Files"})
    vim.keymap.set('n', '<leader>tg', builtin.git_files, {desc = "Find Git Files"})

    vim.keymap.set('n', '<leader>tw', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end, {desc = "Search Word"})

    vim.keymap.set('n', '<leader>tW', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end, {desc = "Search Word Case"})

    vim.keymap.set('n', '<leader>tsg', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, {desc = "Search > "})

    vim.keymap.set('n', '<leader>th', builtin.help_tags, {desc = "Help"})
  end
}

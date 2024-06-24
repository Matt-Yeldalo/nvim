return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<leader>ha',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'harpoon file',
      },
      {
        '<C-e>',
        function()
          local harpoon = require 'harpoon'
          require('harpoon').ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'harpoon quick menu',
      },
      {
        '<leader>j',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'harpoon to file 1',
      },
      {
        '<leader>k',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'harpoon to file 2',
      },
      {
        '<leader>l',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'harpoon to file 3',
      },
      {
        '<leader>;',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'harpoon to file 4',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'harpoon to file 5',
      },
      {
        '<leader><C-j>',
        function()
          require('harpoon'):list():replace_at(1)
        end,
        desc = 'replace harpoon at 1',
      },
      {
        '<leader><C-k>',
        function()
          require('harpoon'):list():replace_at(1)
        end,
        desc = 'replace harpoon at 2',
      },
      {
        '<leader><C-l>',
        function()
          require('harpoon'):list():replace_at(1)
        end,
        desc = 'replace harpoon at 3',
      },
      {
        '<leader><C-;>',
        function()
          require('harpoon'):list():replace_at(1)
        end,
        desc = 'replace harpoon at 4',
      },
    },
  },
}

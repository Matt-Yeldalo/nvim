return {
  "ThePrimeagen/harpoon",
  branch = 'harpoon2',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon Menu" })
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })
    vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "Harpoon 6" })
    vim.keymap.set("n", "<leader><C-1>", function() harpoon:list():replace_at(1) end)
    vim.keymap.set("n", "<leader><C-2>", function() harpoon:list():replace_at(2) end)
    vim.keymap.set("n", "<leader><C-3>", function() harpoon:list():replace_at(3) end)
    vim.keymap.set("n", "<leader><C-4>", function() harpoon:list():replace_at(4) end)
  end
}

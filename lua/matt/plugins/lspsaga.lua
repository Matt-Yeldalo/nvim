return {
  'nvimdev/lspsaga.nvim',
  config = function()
    vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
    vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { desc = '[LSP] [P]eek [D]efinition' })
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = '[LSP] Hover Doc' })
    return require('lspsaga').setup {}
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}

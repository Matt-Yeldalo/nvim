return {
  'zbirenbaum/copilot-cmp',
  config = function()
    require('copilot_cmp').setup {
      mappings = {
        reset = {
          normal = '',
          insert = '',
          callback = function()
            copilot.reset()
          end,
        },
      },
    }
    -- Copilot autosuggestions
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_hide_during_completion = false
    vim.g.copilot_proxy_strict_ssl = false
    vim.g.copilot_settings = { selectedCompletionModel = 'gpt-4o-copilot' }
    vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
    vim.keymap.set('n', '<leader>cp', '<cmd>CopilotChatOpen<CR>', {})
  end,
}

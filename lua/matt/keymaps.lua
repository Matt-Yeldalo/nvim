local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<C-i>', '<C-i>', opts)

-- Better window navigation
-- keymap('n', '<m-h>', '<C-w>h', opts)
-- keymap('n', '<m-j>', '<C-w>j', opts)
-- keymap('n', '<m-k>', '<C-w>k', opts)
-- keymap('n', '<m-l>', '<C-w>l', opts)
-- keymap('n', '<m-tab>', '<c-6>', opts)

keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)
keymap('n', '*', '*zz', opts)
keymap('n', '#', '#zz', opts)
keymap('n', 'g*', 'g*zz', opts)
keymap('n', 'g#', 'g#zz', opts)
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

keymap('x', 'p', [["_dP]])

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set('n', '<RightMouse>', '<cmd>:popup mousemenu<CR>')
vim.keymap.set('n', '<Tab>', '<cmd>:popup mousemenu<CR>')

-- more good
keymap({ 'n', 'o', 'x' }, '<s-h>', '^', opts)
keymap({ 'n', 'o', 'x' }, '<s-l>', 'g_', opts)

-- tailwind bearable to work with
keymap({ 'n', 'x' }, 'j', 'gj', opts)
keymap({ 'n', 'x' }, 'k', 'gk', opts)
keymap('n', '<leader>w', ':lua vim.wo.wrap = not vim.wo.wrap<CR>', opts)

vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', opts)

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Set ; -> : for faster commands
vim.keymap.set('n', ';', ':')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

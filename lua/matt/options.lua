vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.nu = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.o.cmdheight = 0
vim.o.cursorline = false
vim.o.wrap = false
vim.o.laststatus = 0
-- Tab size
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'
vim.cmd 'hi CursorLine guibg=NONE guifg=NONE' -- Hide cursor line/bar
vim.cmd 'hi CursorLineNR guibg=NONE guifg=NONE'
vim.cmd 'hi LineNr guibg=NONE' -- Hide background of line numbers
vim.cmd 'hi GitSignsAdd guibg=NONE'
vim.cmd 'hi GitSignsChange guibg=NONE'
vim.cmd 'hi GitSignsDelete guibg=NONE'
vim.cmd 'hi GitGutterChange guibg=NONE'
vim.cmd 'hi GitGutterAdd guibg=NONE'
vim.cmd 'hi GitGutterChangeLine guibg=NONE'
vim.cmd 'hi GitGutterChangeLineNr guibg=NONE'
vim.cmd 'hi DiagnosticError guibg=NONE'
vim.cmd 'hi DiagnosticSignError guibg=NONE'
vim.cmd 'hi DiagnosticSignHint guibg=NONE'
vim.cmd 'hi DiagnosticSignInfo guibg=NONE'
vim.cmd 'hi DiagnosticSignWarn guibg=NONE'
require 'matt.remaps'
require 'matt.options'
local icons = require 'matt.icons'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines
  -- { -- Adds git related signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
      -- { 'folke/neodev.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      if vim.g.have_nerd_font then
        -- local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local signs = {
          ERROR = icons.diagnostics.Error,
          WARN = icons.diagnostics.Warning,
          INFO = icons.diagnostics.Information,
          HINT = icons.diagnostics.Hint,
        }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config { signs = { text = diagnostic_signs } }
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      local servers = {
        rubocop = {
          cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
          root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git', '.'),
          filetypes = { 'rb', 'ruby' },
          mason = false,
          -- cmd = { os.getenv 'HOME' .. '/.rbenv/shims/rubocop' },
          -- cmd = { '/home/matt/.bundle/ruby/3.4.0/bin/rubocop' },
          -- cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
          -- mason = false,
          -- root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git', '.'),
        },
        solargraph = {
          root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git', '.'),
          filetypes = { 'rb', 'ruby' },
          mason = false,
          -- cmd = { os.getenv 'HOME' .. '/.rbenv/shims/solargraph' },
          -- cmd = { '/home/matt/.bundle/ruby/3.4.0/bin/solargraph' },
          -- filetypes = { 'rb', 'ruby' },
          -- mason = false,
          -- cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
          -- root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git', '.'),
        },
        cssls = {},
        ts_ls = {},
        elixirls = {
          cmd = { 'elixir-ls' },
          filetypes = { 'elixir', 'eelixir', 'heex', 'surface', 'ex', 'exs' },
        },
        lua_ls = {
          -- cmd = {},
          -- filetypes = {},
          capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        zls = {
          cmd = { '/home/matt/.zls/zls' },
          root_dir = require('lspconfig.util').root_pattern('.git', 'build.zig', 'zls.json'),
          settings = {
            zls = {
              enable_inlay_hints = true,
              enable_snippets = true,
              warn_style = true,
            },
          },
        },
        -- tailwindcss = {
        --   mason = false,
        --   filetypes = { 'eruby', 'erb' },
        --   settings = {
        --     tailwindCSS = {
        --       experimental = {
        --         classRegex = {
        --           -- Regex for Tailwind in Rails helpers
        --           [[class: ["']([^"']*)["']],                       -- Match class: "text-blue-500"
        --           [[content_tag\s*:\w+.*class:\s*["']([^"']*)["']], -- Match content_tag helper
        --           [[tag\.\w+\s*.*class:\s*["']([^"']*)["']],        -- Match tag helper
        --         },
        --       },
        --     },
        --   },
        -- },
        -- clangd = {},
        -- eslint = {
        --   mason = false,
        --   filetypes = { 'javascript', 'js', 'ts' },
        --   cmd = {'eslint'}
        --   -- cmd = {''},
        -- },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })
      -- require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      vim.keymap.set({ 'n', 'v' }, '<leader>fi', function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end, { desc = '[F]ormat buffer' })

      require('conform').setup {
        formatters = {
          rubocop = {
            cwd = require('conform.util').root_file { 'Gemfile', '.git', '.gitignore', '.editorconfig', 'package.json' },
            command = os.getenv 'HOME' .. '/.rbenv/shims/rubocop',
            -- command = os.getenv 'HOME' .. '/.bundle/ruby/3.2.0/bin/rubocop',
            -- command =  require('conform.util').root_file { 'Gemfile', '.git', '.gitignore', '.editorconfig', 'package.json' } .. '/.bundle/ruby/**/bin/rubocop',
            -- command = './.bundle/ruby/**/bin/rubocop',
            -- args = { "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
            args = { '--server', '--autocorrect-all', '--stderr', '--force-exclusion', '--stdin', '$FILENAME' },
            timeout_ms = 1000,
            -- args = { '--server', '--auto-correct-all', '--stderr', '--force-exclusion', '--stdin', '$FILENAME' },
            -- args = { '--format', '--server', '--auto-correct-all', '--stderr', '--force-exclusion', '--stdin', '$FILENAME' },
            -- args = {'--format'},
            -- command = os.getenv 'HOME' .. '/.rbenv/shims/rubocop',
            -- root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]),
            -- root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git', '.'),
          },
          erb_formatter = {
            cwd = require('conform.util').root_file { 'Gemfile', '.gitignore', '.editorconfig', 'package.json' },
            command = os.getenv 'HOME' .. '/.rbenv/shims/erb-format',
            -- command = 'bundle exec erb-format',
            -- command = os.getenv 'HOME' .. '/.bundle/ruby/3.2.0/bin/erb-format',
            -- command = './.bundle/ruby/*/bin/erb-format',
            -- command = os.getenv 'HOME' .. '/.rbenv/shims/erb-format',
            args = { '--stdin', '--print-width', '140' },
          },
          eslint = {
            command = 'eslint',
            args = { '--stdin' },
          },
        },
        notify_on_error = true,
        formatters_by_ft = {
          ex = { 'elixir-ls' },
          exs = { 'elixir-ls' },
          lua = { 'stylua' },
          ruby = { 'rubocop' },
          rb = { 'rubocop' },
          javascript = { 'ts_ls', 'prettierd', 'prettier', stop_after_first = true },
          c = { 'clangd' },
          markdown = { 'markdownlint' },
          html = { 'htmlbeautifier' },
          erb = { 'erb_formatter' },
          eruby = { 'erb_formatter' },
          css = { 'cssls' },
          scss = { 'cssls', 'prettier', stop_after_first = true },
        },
      }
    end,
    --   vim.api.nvim_create_user_command('Format', function(args)
    --     local range = nil
    --     if args.count ~= -1 then
    --       local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    --       range = {
    --         start = { args.line1, 0 },
    --         ['end'] = { args.line2, end_line:len() },
    --       }
    --     end
    --     require('conform').format { async = true, lsp_format = 'never', range = range }
    --   end, { range = true })
    -- end,
    keys = {
      -- {
      --   '<leader>f',
      --   require('conform').format { async = true, lsp_format = 'fallback' },
      --   -- mode = { 'n', 'v' },
      --   mode = '',
      --   desc = '[F]ormat buffer',
      -- },
    },
    -- opts = {
    --   formatters = {
    --     rubocop = {
    --       cwd = require("conform.util").root_file({ "Gemfile", ".gitignore", ".editorconfig", "package.json" }),
    --       command = 'bundle exec rubocop',
    --       args = { '--server', '--auto-correct-all', '--stderr', '--force-exclusion', '--stdin', '$FILENAME' },
    --       -- args = { '--format', '--server', '--auto-correct-all', '--stderr', '--force-exclusion', '--stdin', '$FILENAME' },
    --       -- args = {'--format'},
    --       -- command = os.getenv 'HOME' .. '/.rbenv/shims/rubocop',
    --       -- root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Gemfile' }, { upward = true })[1]),
    --       -- root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git', '.'),
    --     },
    --     erb_formatter = {
    --       cwd = require("conform.util").root_file({ "Gemfile", ".gitignore", ".editorconfig", "package.json" }),
    --       command = 'bundle exec erb-format',
    --       -- command = os.getenv 'HOME' .. '/.rbenv/shims/erb-format',
    --       args = { '--stdin', '--print-width', '140' },
    --     },
    --     eslint = {
    --       command = 'eslint',
    --       args = { '--stdin' },
    --     },
    --   },
    --   notify_on_error = true,
    --   formatters_by_ft = {
    --     ex = { 'elixir-ls' },
    --     exs = { 'elixir-ls' },
    --     lua = { 'stylua' },
    --     ruby = { 'rubocop' },
    --     rb = { 'rubocop' },
    --     javascript = { 'ts_ls', 'prettierd', 'prettier', stop_after_first = true },
    --     c = { 'clangd' },
    --     markdown = { 'markdownlint' },
    --     html = { 'htmlbeautifier' },
    --     erb = { 'erb_formatter' },
    --     eruby = { 'erb_formatter' },
    --     css = { 'cssls' },
    --     scss = { 'cssls', 'prettier', stop_after_first = true },
    --   },
    -- },
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.icons').setup()
      require('mini.surround').setup()
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }
      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- --- @diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      endwise = {
        enable = true,
      },
      playground = {
        enable = true,
      },
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.gitsigns',
  -- TODO: move to my own plugins dir
  require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  { import = 'matt.plugins' },
}, {
  change_detection = { notify = false },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.cmd 'Copilot disable'


-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10 -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

vim.o.wrap = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.cindent = true
vim.o.cinoptions = "(0,L0,:1,l1"
vim.g.editorconfig = false
vim.g.have_nerd_font = true
vim.opt.termguicolors = true

-- make sure sign gutter is visible to remove jitter
vim.opt.signcolumn = 'yes'

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- Map jk to <Esc>
vim.keymap.set({ 't', 'i' }, 'jk', '<Esc>')

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`
--

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
  -- icons
  'https://github.com/nvim-tree/nvim-web-devicons',
  -- LSP
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  -- finder
  'https://github.com/ibhagwan/fzf-lua',
  -- autocomplete
  'https://github.com/nvim-mini/mini.completion',
  -- Enhanced quickfix/loclist
  'https://github.com/stevearc/quicker.nvim',
  -- Git integration
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/kdheepak/lazygit.nvim',
  -- DAP
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
  -- statusline
  'https://github.com/nvim-lualine/lualine.nvim',
})

--
--
-- basic inits

require('mason').setup()
FzfLua = require('fzf-lua')
FzfLua.setup { fzf_colors = true }
require('mini.completion').setup {}
require('quicker').setup {}
require('gitsigns').setup {}
require('lualine').setup {}

vim.cmd('colorscheme catppuccin')

--
--
-- LSP setup

vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')

--
--
-- keymaps

vim.keymap.set({ 'n' }, '<C-p>', FzfLua.files)
vim.keymap.set({ 'n' }, '<M-j>', vim.lsp.buf.definition)
vim.keymap.set({ 'n' }, '<M-k>', '<C-o>')
vim.keymap.set({ 'n' }, '<leader>gg', function()
    vim.cmd('LazyGit')
end)
vim.keymap.set({ 'n' }, 'grr', FzfLua.lsp_references)
vim.keymap.set('n', '<m-o>', function()
    vim.cmd('LspClangdSwitchSourceHeader')
end, { desc = "clangd switch header" })

-- interactive terminal
vim.keymap.set('n', '<leader>t', function()
    vim.cmd('botright 15split | term')
    vim.cmd('startinsert')
end, { desc = "open terminal" })

vim.diagnostic.config({
  virtual_text = false,
})

--
--
-- edit-compile-edit loop

function BuildProject()
  vim.cmd("wa")  -- save all files
  vim.fn.setqflist({})  -- clear quickfix
  vim.cmd("botright copen") -- open quickfix
  vim.cmd("wincmd p") -- get cursor out of quickfix window 

  vim.notify("⏳ Build started ...", vim.log.levels.INFO)

  local build_script
  local os_name = vim.loop.os_uname().sysname
  if string.find(os_name, 'Windows') ~= nil then
      build_script = "./code/build.bat"
  else
      build_script = "./code/build.sh"
  end

  vim.fn.jobstart({ build_script }, {
    --cwd = parent_folder,
    stdout_buffered = false,
    stderr_buffered = false,

    on_stdout = function(_, data)
      if data then
        vim.fn.setqflist({}, 'a', { lines = data })
        --vim.cmd("cwindow")
      end
    end,

    on_stderr = function(_, data)
      if data then
        vim.fn.setqflist({}, 'a', { lines = data })
        --vim.cmd("cwindow")
      end
    end,

    on_exit = function(_, code)
      local errorCount = 0
      for k, v in pairs(vim.fn.getqflist()) do
          if v.valid == 1 then
              errorCount = errorCount + 1
          end
      end
      if code == 0 and errorCount == 0 then
        vim.notify("✅ Build succeeded", vim.log.levels.INFO)
      else
        vim.notify("❌ Build failed", vim.log.levels.ERROR)
      end
    end
  })
end
vim.keymap.set("n", "<m-m>", BuildProject, { noremap = true, silent = true, desc = "Build Project" })
vim.keymap.set('n', '<m-n>', ':cn<CR>', { desc = "go to next quickfix error" })
vim.keymap.set('n', '<m-p>', ':cp<CR>', { desc = "go to previous quickfix error" })
vim.keymap.set('n', '<m-,>', ':cclose<CR>', { desc = "close quickfix window" })


--
--
-- DAP setup

-- https://emojipedia.org/en/stickers/search?q=circle
vim.fn.sign_define('DapBreakpoint',
{
    text = '🔴',
    texthl = 'DapBreakpointSymbol',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
})

vim.fn.sign_define("DapStopped",
{
    text = "➡️",
    texthl = "DiagnosticWarn",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define('DapBreakpointRejected',
{
    text = '⭕',
    texthl = 'DapStoppedSymbol',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint'
})

local dap = require('dap')
dap.adapters.codelldb = {
    type = 'executable',
    command = 'codelldb',
}

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            local target_filepath = vim.fn.getcwd()..'/nvim-dap-cpp-target.txt'
            local target_file = io.open(target_filepath, 'r')
            if target_file then
                local target_path = target_file:read()
                target_file:close()
                vim.notify("using exe path: "..target_path, vim.log.levels.INFO)
                return target_path
            else
                local target_path = vim.fn.input('Path to exe: ', vim.fn.getcwd() .. '/', 'file')
                local f = io.open(target_filepath, 'w')
                if f then
                    f:write(target_path)
                    f:close()
                else
                    vim.notify("failed to save choice of exe path to "..target_filepath, vim.log.levels.WARN)
                end
                return target_path
            end
        end,
        args = {},
        cwd = function()
            return vim.fn.getcwd() .. "/build"
        end,
        stopOnEntry = false,
        showDisassembly = "never",
    }
}

vim.keymap.set('n', '<F5>', dap.continue, { desc = "DAP: continue" })
vim.keymap.set('n', '<F17>', dap.terminate, { desc = "DAP: terminate" }) -- terminal-mode keycode for s-F5
vim.keymap.set('n', '<s-F5>', dap.terminate, { desc = "DAP: terminate" })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "DAP: step over" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "DAP: step into" })
vim.keymap.set('n', '<F23>', dap.terminate, { desc = "DAP: terminate" }) -- terminal-mode keycode for s-F11
vim.keymap.set('n', '<s-F11>', dap.step_out, { desc = "DAP: step out" })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })

local dapui = require('dapui')
dapui.setup({
    controls = { enabled = false, },
    element_mappings = {
        stacks = {
            open = "<CR>",
            expand = "o",
        },
    },
    expand_lines = true,
    floating = {
      border = "rounded",
      mappings = { close = { "q", "<Esc>" } }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
        elements = { {
            id = "watches",
            size = 1.0
          },
        },
        position = "right",
        size = 40
      },
      {
        elements = { {
            id = "console",
            size = 1.0
          }, },
        position = "bottom",
        size = 10
      },
    },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

vim.keymap.set('n', '<leader>?', function()
    dapui.eval()
    dapui.eval()
end, { desc = "DAP: eval expression" })

vim.keymap.set('n', '<leader>ds', function()
    dapui.float_element('stacks', { enter = true })
end, { desc = "DAP: Show stacks in floating window" })
vim.keymap.set('n', '<leader>dc', function()
    dapui.float_element('console', { enter = true })
end, { desc = "DAP: Show console in floating window" })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.autoformat = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

vim.g.have_nerd_font = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

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

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.wrap = true -- Enable line wrapping
vim.o.cursorline = false
vim.opt.list = false
vim.opt.tabstop = 2

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
}

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--keymaps here because keymaps.lua does not work

vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

-- Move selected block of text down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected text down' })

-- Move selected block of text up in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected text up' })

-- Join the current line with the line below, keeping the cursor in place
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line below, keep cursor position' })

-- Scroll down half a page and center the cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })

-- Scroll up half a page and center the cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

-- Go to the next search result and center the cursor
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })

-- Go to the previous search result and center the cursor
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

-- Start collaborative editing with 'vim-with-me' plugin
vim.keymap.set('n', '<leader>vwm', function()
  require('vim-with-me').StartVimWithMe()
end, { desc = 'Start vim with me theprimeagean ' })

-- Stop collaborative editing with 'vim-with-me' plugin
vim.keymap.set('n', '<leader>svwm', function()
  require('vim-with-me').StopVimWithMe()
end, { desc = 'Stop vim with me' })

-- Replace the selected text with the paste register without copying the selected text
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste over selection without yanking' })

-- Copy to the system clipboard in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })

-- Copy the current line to the system clipboard in normal mode
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })

-- Delete text without copying it to a register (normal and visual modes)
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without copying' })

-- Map Ctrl-c to behave like Escape in insert mode
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = 'Map Ctrl-c to Escape in insert mode' })

-- Disable the Q command, which by default enters Ex mode
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disable Q (Ex mode)' })

-- Open a new tmux window and run the sessionizer command
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux new tmux-sessionizer<CR>', { desc = 'Run tmux sessionizer' })

-- Format the current buffer with the language server's formatting feature
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer with LSP' })

-- Go to the next item in the quickfix list and center the cursor
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Next quickfix item and center' })

-- Go to the previous item in the quickfix list and center the cursor
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix item and center' })

-- Go to the next item in the location list and center the cursor
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next location list item and center' })

-- Go to the previous item in the location list and center the cursor
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Previous location list item and center' })

-- Replace the word under the cursor throughout the file
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor globally' })


-- Make the current file executable (chmod +x) with <leader>x
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable' })

-- Source the current file
vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end, { desc = 'Source current file' })

require('lazy').setup {
  spec = {
    -- add LazyVim and import its plugins
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = 'plugins' },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { 'tokyonight', 'habamax' } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },                -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

-- Replace the selected text with the paste register without copying the selected text
vim.keymap.set('x', '<leader>op', [["_dP]], { desc = 'Paste over selection without yanking' })

-- Copy to the system clipboard in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

-- Copy the current line to the system clipboard in normal mode
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })

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
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor globally' })

-- Split vertical pane
vim.keymap.set('n', '<leader>hs', ':split<CR><C-w>w', { desc = 'split neovim window horizontal' })
vim.keymap.set('n', '<leader>vs', ':vsplit<CR><C-w>w', { desc = 'split neovim window vertical' })

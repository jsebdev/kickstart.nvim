-- local map = require('custom.utils.keymap').defaultMap

-- reload config
vim.keymap.set('n', '<leader>xs', function()
  require('custom.utils.reload').reload()
end, { desc = 'Reload init.lua' })

-- automatically close opened parentesis
-- vim.keymap.set('i', '(', '()<esc>i', { desc = 'close parentesis automatically' })
-- vim.keymap.set('i', '{', '{}<esc>i', { desc = 'close parentesis automatically' })
-- vim.keymap.set('i', '[', '[]<esc>i', { desc = 'close parentesis automatically' })

-- automatically close opened quotes
-- vim.keymap.set('i', '"', '""<esc>i', { desc = 'close parentesis automatically' })
-- vim.keymap.set('i', "'", "''<esc>i", { desc = 'close parentesis automatically' })
-- vim.keymap.set('i', '`', '``<esc>i', { desc = 'close parentesis automatically' })

-- workspace shortcuts
vim.keymap.set('n', '<leader>ww', ':w<cr>', { desc = '[W]orkspace [w]rite' })
vim.keymap.set('n', '<leader>wW', ':wa<cr>', { desc = '[W]orkspace [w]rite all' })
vim.keymap.set('n', '<leader>wQ', ':qa<cr>', { desc = '[W]orkspace [Q]uit all' })
vim.keymap.set('n', '<leader>wq', ':q<cr>', { desc = '[W]orkspace [q]quit' })
vim.keymap.set('n', '<C-q>', ':close<CR>', { desc = 'quit current editor' })

-- tab navigation
-- map <C-S-k> in kitty
-- vim.keymap.set('n', '<Esc>[1;6A', ':tabnext<CR>', { noremap = true, silent = true })
-- map <C-S-j> in kitty
-- vim.keymap.set('n', '<Esc>[1;6B', ':tabprevious<CR>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i'}, '<C-j>', function()
  vim.cmd('stopinsert')
  vim.cmd('tabprevious')
end, { noremap = true, silent = true })
vim.keymap.set({'n', 'i'}, '<C-k>', function()
  vim.cmd('stopinsert')
  vim.cmd('tabnext')
end, { noremap = true, silent = true })

-- windows management
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = '[W]orkspace split [V]ertically' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = '[W]orkspace split [H]orizontally' })

vim.keymap.set('n', '<A-h>', ':vertical resize -2<CR>', { desc = 'Resize window left' })
vim.keymap.set('n', '<A-l>', ':vertical resize +2<CR>', { desc = 'Resize window right' })
vim.keymap.set('n', '<A-j>', ':resize -2<CR>', { desc = 'Resize window down' })
vim.keymap.set('n', '<A-k>', ':resize +2<CR>', { desc = 'Resize window up' })

vim.keymap.set('n', '<leader>wz', ':tab split<CR>', { desc = '[W]orkspace [Z]oom windows to new tab' })

-- Debug helpers
--map('n', 'di', require('utils.LogRawKeySequence').LogRawKeySequence, '[D]ebug [I]nput')

-- the one I want is <C-/> but for some reason I had to map <C-_> instead
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'comment single line' })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'comment single line' })

-- smart selection ignoring escaped quotes
vim.keymap.set({ 'o', 'x' }, 'iq', require('custom.utils.select_inside_unescaped_quotes').select_inside_unescaped_quotes, { desc = 'smart inside quotes' })

-- formating
vim.keymap.set({'n', 'x'}, '=', function() vim.lsp.buf.format {async = false} end, { desc = 'Autoformat'})

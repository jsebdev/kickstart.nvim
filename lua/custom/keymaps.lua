local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- reload config
vim.keymap.set('n', '<leader>sv', function()
  require('custom.reload').reload()
end, { desc = 'Reload init.lua' })

-- automatically close opened parentesis
vim.keymap.set('i', '(', '()<esc>i', { desc = 'close parentesis automatically' })
vim.keymap.set('i', '{', '{}<esc>i', { desc = 'close parentesis automatically' })
vim.keymap.set('i', '[', '[]<esc>i', { desc = 'close parentesis automatically' })

-- automatically close opened quotes
vim.keymap.set('i', '"', '""<esc>i', { desc = 'close parentesis automatically' })
vim.keymap.set('i', "'", "''<esc>i", { desc = 'close parentesis automatically' })
vim.keymap.set('i', '`', '``<esc>i', { desc = 'close parentesis automatically' })

-- workspace shortcuts
vim.keymap.set('n', '<leader>ww', ':w<cr>', { desc = '[W]orkspace [w]rite' })
vim.keymap.set('n', '<leader>wW', ':wa<cr>', { desc = '[W]orkspace [w]rite all' })
vim.keymap.set('n', '<leader>wq', ':q<cr>', { desc = '[W]orkspace [q]quit' })

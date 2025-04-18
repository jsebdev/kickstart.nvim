local opts = { noremap = true, silent = true }

-- reload config
vim.keymap.set('n', '<leader>xs', function()
  require('custom.utils.reload').reload()
end, { desc = 'Reload init.lua' })

-- workspace shortcuts
vim.keymap.set('n', '<leader>ww', ':w<cr>', { desc = '[W]orkspace [w]rite' })
vim.keymap.set('n', '<leader>wW', ':wa<cr>', { desc = '[W]orkspace [w]rite all' })
vim.keymap.set('n', '<leader>wQ', ':qa<cr>', { desc = '[W]orkspace [Q]uit all' })

vim.keymap.set('n', '<leader>wq', function()
  require('custom.utils.smart_windows_close').smart_windows_close(_G.closed_buffers)
end, { desc = '[W]orkspace [q]quit' })
vim.keymap.set('n', '<C-w>', function()
  require('custom.utils.smart_windows_close').smart_windows_close(_G.closed_buffers)
end, { desc = '[W]orkspace [q]quit' })
vim.keymap.set('n', '<leader>wo', ':only<cr>', { desc = '[W]orkspace leave [o]nly this windows open' })

vim.keymap.set('n', '<leader>wr', function()
  require('custom.utils.open_closed_buffer').open_closed_buffer(_G.closed_buffers)
end, { desc = '[W]orkspace [r]eopen last closed buffer' })

-- tab navigation
vim.keymap.set({'n', 'i', 'v', 't'}, '<C-j>', function()
  vim.cmd('stopinsert')
  vim.cmd('tabprevious')
end, { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v', 't'}, '<C-k>', function()
  vim.cmd('stopinsert')
  vim.cmd('tabnext')
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>wc", function()
  local current_tab = vim.api.nvim_get_current_tabpage()
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    if tab ~= current_tab then
      vim.api.nvim_set_current_tabpage(tab)
      vim.cmd("tabclose")
    end
  end
  vim.api.nvim_set_current_tabpage(current_tab)
end, { desc = "[W]orkspace [C]lose all other tabs" })

-- windows management
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { desc = '[W]orkspace split [V]ertically' })
vim.keymap.set('n', '<leader>wh', ':split<CR>', { desc = '[W]orkspace split [H]orizontally' })

vim.keymap.set('n', '<A-w>h', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('vertical resize -' .. count)
end, { desc = '[W]orkspace Resize window left [H]' })
vim.keymap.set('n', '<A-w>l', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('vertical resize +' .. count)
end, { desc = '[W]orkspace Resize window right [L]' })
vim.keymap.set('n', '<A-w>j', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('resize -' .. count)
end, { desc = '[W]orkspace Resize window down [J]' })
vim.keymap.set('n', '<A-w>k', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('resize +' .. count)
end, { desc = '[W]orkspace Resize window up [K]' })


vim.keymap.set('n', '<leader>wz', function() vim.cmd('tab split') end, { desc = '[W]orkspace [Z]oom windows to new tab' })

-- Debug helpers
vim.keymap.set('n', '<leader>di', require('custom.utils.LogRawKeySequence').LogRawKeySequence, { desc = '[D]ebug [I]nput'})

-- the one I want is <C-/> but for some reason I had to map <C-_> instead
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'comment single line' })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'comment single line' })

-- smart selection ignoring escaped quotes
vim.keymap.set({ 'o', 'x' }, 'iq', require('custom.utils.select_inside_unescaped_quotes').select_inside_unescaped_quotes, { desc = 'smart inside quotes' })

-- formating
vim.keymap.set({'n', 'x'}, '=', function() vim.lsp.buf.format {async = false} end, { desc = 'Autoformat'})
vim.keymap.set('n', '<leader>cu', 'gUiwe', { desc = '[C]ode [u]ppercase'})
vim.keymap.set('n', '<leader>cU', 'guiwe', { desc = '[C]ode lowercase [U]'})
vim.keymap.set('v', '<leader>cu', 'gU', { desc = '[C]ode [u]ppercase'})
vim.keymap.set('v', '<leader>cU', 'gu', { desc = '[C]ode lowercase [U]'})

-- esc insertmode
vim.keymap.set('i', '<Esc>', '<Nop>', { noremap = true })
vim.keymap.set('i', 'kj', '<Esc>', {noremap = true, silent = true})

-- toggles
vim.keymap.set('n', '<leader>tr', function()
  vim.opt.relativenumber = not vim.wo.relativenumber
end, { desc = '[T]oggle [R]elative numbers' })

vim.keymap.set('n', '<leader>tb', require('custom.utils.toggle_big_files_stuff').toggle_big_files_stuff, { desc = '[T]oggle [B]ig file mode (buffer-local)' })

-- yank and selected registers
vim.keymap.set({'n', 'v'}, '<C-c>', '"+y', { desc = 'Copy to clipboard' })
-- <C-v> already pastes from clipboard somehow


-- smart debug prints
vim.keymap.set('n', '<leader>zp', function()
  require('custom.utils.smart_print').print_current_line_with_formats('print(">>>>> %s:%d \'%s\'")', 'print(%s)')
end, { desc = "Smart print in python" })

vim.keymap.set('n', '<leader>zjj', function()
  require('custom.utils.smart_print').print_current_line_with_formats('console.log(">>>>> %s:%d \'%s\'");', 'console.log(%s);')
end, { desc = "Smart print in javascript" })

vim.keymap.set('n', '<leader>zjp', function()
  require('custom.utils.smart_print').print_current_line_with_formats('console.log(">>>>> %s:%d \'%s\'");', 'console.log(JSON.stringify(%s, null, 2));')
end, { desc = "Smart print in javascript" })


-- move tabs
vim.keymap.set({'n', 'i', 'v'}, '<A-u>', function()
  local current = vim.fn.tabpagenr()
  if current > 1 then
    vim.cmd('-tabmove')
  end
end, { desc = 'Move tab left' })

vim.keymap.set({'n', 'i', 'v'}, '<A-i>', function()
  local current = vim.fn.tabpagenr()
  local total = vim.fn.tabpagenr('$')
  if current < total then
    vim.cmd('+tabmove')
  end
end, { desc = 'Move tab right' })


-- playing macros
vim.keymap.set("n", "<leader>@", function()
  local reg = vim.fn.getcharstr()
  local count = vim.v.count > 0 and vim.v.count or 1
  vim.schedule(function()
    vim.cmd("silent! normal! " .. count .. "@" .. reg)
  end)
end, { noremap = true, desc = "Play macro silently with count support" })


--terminal
vim.api.nvim_set_keymap('t', 'kj', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.keymap.set('t', '<C-R>', function()
  local char = vim.fn.getchar()
  if type(char) == "number" then
    char = vim.fn.nr2char(char)
  end
  return '<C-\\><C-N>"' .. char .. 'pi'
end, { expr = true, noremap = true })


-- move among windows
vim.keymap.set('t', '<A-h>', [[<C-\><C-N><C-w>h]], opts)
vim.keymap.set('t', '<A-j>', [[<C-\><C-N><C-w>j]], opts)
vim.keymap.set('t', '<A-k>', [[<C-\><C-N><C-w>k]], opts)
vim.keymap.set('t', '<A-l>', [[<C-\><C-N><C-w>l]], opts)
vim.keymap.set('i', '<A-h>', [[<C-\><C-N><C-w>h]], opts)
vim.keymap.set('i', '<A-j>', [[<C-\><C-N><C-w>j]], opts)
vim.keymap.set('i', '<A-k>', [[<C-\><C-N><C-w>k]], opts)
vim.keymap.set('i', '<A-l>', [[<C-\><C-N><C-w>l]], opts)
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)



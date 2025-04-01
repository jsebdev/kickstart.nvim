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

vim.keymap.set('n', '<leader>wq', function()
  require('custom.utils.smart_windows_close').smart_windows_close(_G.closed_buffers)
end, { desc = '[W]orkspace [q]quit' })
vim.keymap.set('n', '<C-q>', function()
  require('custom.utils.smart_windows_close').smart_windows_close(_G.closed_buffers)
end, { desc = '[W]orkspace [q]quit' })

vim.keymap.set('n', '<leader>wr', function()
  require('custom.utils.open_closed_buffer').open_closed_buffer(_G.closed_buffers)
end, { desc = '[W]orkspace [r]eopen last closed buffer' })

-- tab navigation
-- map <C-S-k> in kitty
-- vim.keymap.set('n', '<Esc>[1;6A', ':tabnext<CR>', { noremap = true, silent = true })
-- map <C-S-j> in kitty
-- vim.keymap.set('n', '<Esc>[1;6B', ':tabprevious<CR>', { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<C-j>', function()
  vim.cmd('stopinsert')
  vim.cmd('tabprevious')
end, { noremap = true, silent = true })
vim.keymap.set({'n', 'i', 'v'}, '<C-k>', function()
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

vim.keymap.set('n', '<C-w>h', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('vertical resize -' .. count)
end, { desc = '[W]orkspace Resize window left [H]' })
vim.keymap.set('n', '<C-w>l', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('vertical resize +' .. count)
end, { desc = '[W]orkspace Resize window right [L]' })
vim.keymap.set('n', '<C-w>j', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('resize -' .. count)
end, { desc = '[W]orkspace Resize window down [J]' })
vim.keymap.set('n', '<C-w>k', function()
  local count = vim.v.count > 0 and vim.v.count or 2
  vim.cmd('resize +' .. count)
end, { desc = '[W]orkspace Resize window up [K]' })


vim.keymap.set('n', '<leader>wz', function() vim.cmd('tab split') end, { desc = '[W]orkspace [Z]oom windows to new tab' })

-- Debug helpers
--map('n', 'di', require('utils.LogRawKeySequence').LogRawKeySequence, '[D]ebug [I]nput')

-- the one I want is <C-/> but for some reason I had to map <C-_> instead
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'comment single line' })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'comment single line' })

-- smart selection ignoring escaped quotes
vim.keymap.set({ 'o', 'x' }, 'iq', require('custom.utils.select_inside_unescaped_quotes').select_inside_unescaped_quotes, { desc = 'smart inside quotes' })

-- formating
vim.keymap.set({'n', 'x'}, '=', function() vim.lsp.buf.format {async = false} end, { desc = 'Autoformat'})

-- esc insertmode
vim.keymap.set('i', '<Esc>', '<Nop>', { noremap = true })
vim.keymap.set('i', 'kj', '<Esc>', {noremap = true, silent = true})

-- toggles
vim.keymap.set('n', '<leader>tr', function()
  vim.opt.relativenumber = not vim.wo.relativenumber
end, { desc = '[T]oggle [R]elative numbers' })

-- yank and selected registers
vim.keymap.set({'n', 'v'}, '<C-c>', '"+y', { desc = 'Copy to clipboard' })
-- <C-v> already pastes from clipboard somehow

-- debug printers
local function escape_for_fstring(text) -- Escape function for f-string-safe usage
  text = text:gsub('\\', '\\\\')   -- escape backslashes
  text = text:gsub('"', '\\"')     -- escape double quotes
  text = text:gsub('{', '{{')      -- escape left braces
  text = text:gsub('}', '}}')      -- escape right braces
  return text
end

vim.keymap.set('n', '<leader>dp', function()
  local line_num = vim.fn.line('.')
  local line_text = vim.fn.getline('.')
  local safe_text = escape_for_fstring(line_text)
  local snippet = string.format([[print(f"%d: %s >>>\n{%s}")]], line_num, safe_text, line_text)
  vim.api.nvim_put({ snippet }, 'l', true, true)
end, { desc = "[D]ebug print [Python] (line)", noremap = true })

-- vim.keymap.set('x', '<C-S-z>p', function()
--   local line_num = vim.fn.line('.')
--   local selected = vim.fn.getreg('"')
--   local safe_selected = escape_for_fstring(selected)
--   local snippet = string.format([[print(f"%d: %s >>>\n{%s}")]], line_num, safe_selected, selected)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
--   vim.api.nvim_put({ snippet }, 'l', true, true)
-- end, { desc = "[D]ebug print [Python]", noremap = true })
--
vim.keymap.set('v', '<leader>dp', function()
  -- Get visual selection range
  local start_pos = vim.fn.getpos("'<")
  print("Start position: " .. vim.inspect(start_pos))
  local end_pos = vim.fn.getpos("'>")
  print("End position: " .. vim.inspect(end_pos))

  -- Exit visual mode cleanly before any other action
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)

  -- Join selected lines into a single string
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  print("Selected lines: " .. vim.inspect(lines))
  -- local selected_text = table.concat(lines, '\n')
  -- print("Selected text: " .. selected_text)
  --
  -- local safe_text = escape_for_fstring(selected_text)
  -- local line_num = vim.fn.line('.')
  -- local snippet = string.format([[print(f"%d: %s >>>\n{%s}")]], line_num, safe_text, selected_text)
  -- print("Snippet: " .. snippet)
  --
  -- -- Put the debug print below
  -- vim.api.nvim_put({ snippet }, 'l', true, true)
end, { desc = "[D]ebug print [Python] (selection)", noremap = true })

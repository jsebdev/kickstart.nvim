local M = {}

function M.setup()
  require('nvim-tree').setup {}
  vim.keymap.set('n', '<A-b>', ':NvimTreeToggle<cr>', { noremap = true, silent = true })
end

return M

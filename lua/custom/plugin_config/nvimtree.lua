local M = {}

function M.setup()
  require('nvim-tree').setup {
    view = {
      width = 30,
    },
  }
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
  keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
  -- keymap('n', '<leader>n', ':NvimTreeFocus<CR>', opts)
  keymap('n', '<leader>f', ':NvimTreeFindFile<CR>', opts)
  -- keymap('n', '<leader>c', ':NvimTreeCollapse<CR>', opts)
end

return M

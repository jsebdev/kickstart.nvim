local M = {}
local map = require('utils.keymap').map

function M.setup()
  require('nvim-tree').setup {
    view = {
      width = 30,
    },
  }

  map('n', '<leader>e', ':NvimTreeToggle<CR>', 'toggle NvimTree')
  map('n', '<leader>f', ':NvimTreeFindFile<CR>', 'Find file in NvimTree')
end

return M

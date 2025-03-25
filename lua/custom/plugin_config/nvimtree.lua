local M = {}
local map = require('utils.keymap').defaultMap

function M.setup()
  require('nvim-tree').setup {
    view = {
      width = 30,
    },
  }

  map('n', '<leader>ee', ':NvimTreeToggle<CR>', 'Open NvimTree')
  map('n', '<leader>ef', ':NvimTreeFindFile<CR>', 'Find file in NvimTree')
end

return M

local M = {}
local map = require('utils.keymap').defaultMap

function M.setup()
  require('nvim-tree').setup {
    view = {
      width = 30,
    },
  }

  map('n', '<leader>dn', ':NvimTreeToggle<CR>', '[D]ocuments in [N]vimTree')
  map('n', '<leader>df', ':NvimTreeFindFile<CR>', '[D]ocument: [F]ind in NvimTree')
end

return M

local M = {}
local map = require('custom.utils.keymap').defaultMap

local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.del('n', '<C-k>', { buffer = bufnr })
  vim.keymap.set('n', '<C-i>', api.node.show_info_popup, opts 'Info')
end

function M.setup()
  require('nvim-tree').setup {
    view = {
      width = 30,
    },
    on_attach = my_on_attach,
  }

  map('n', '<leader>ee', ':NvimTreeToggle<CR>', 'Open NvimTree')
  map('n', '<leader>ef', ':NvimTreeFindFile<CR>', 'Find file in NvimTree')
end

return M

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

  vim.keymap.del('n', 'a', { buffer = bufnr })
  vim.keymap.set('n', '<C-n><C-f>', api.fs.create, opts 'Create File Or Directory')
end

-- Store the initial root (directory you opened with `nvim .`)
_G.nvim_tree_initial_root = vim.fn.getcwd()

function M.setup()
  require('nvim-tree').setup {
    view = {
      width = 30,
    },
    on_attach = my_on_attach,
  }

  map('n', '<leader>ee', ':NvimTreeToggle<CR>', 'Open NvimTree')
  map('n', '<leader>ef', ':NvimTreeFindFile<CR>', 'Find file in NvimTree')

  vim.keymap.set("n", "<leader>er", function()
    local api = require("nvim-tree.api")
    local root = vim.fn.getcwd()
    print("the roor dir is " .. _G.nvim_tree_initial_root)
    api.tree.change_root(_G.nvim_tree_initial_root)
    api.tree.reload()
  end, { desc = "[E]xplore [R]eset NvimTree to project root" })

end

return M

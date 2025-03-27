local builtin = require('telescope.builtin')

local M = {}

M.lsp_def_in_new_tab = function()
  vim.cmd('tab split')
  builtin.lsp_definitions()
end


return M

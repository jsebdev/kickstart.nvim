local M = {}

local lsp_util = vim.lsp.util
local lsp_buf_request = vim.lsp.buf_request
local api = vim.api
local builtin = require('telescope.builtin')

M.lsp_def_in_new_tab = function()
  local params = lsp_util.make_position_params()

  lsp_buf_request(0, 'textDocument/definition', params, function(err, result, ctx, _)
    if err then
      vim.notify('LSP error: ' .. err.message, vim.log.levels.ERROR)
      return
    end

    if not result or vim.tbl_isempty(result) then
      vim.notify('No definition found', vim.log.levels.INFO)
      return
    end

    vim.cmd('tab split')
    builtin.lsp_definitions()
  end)
end

return M

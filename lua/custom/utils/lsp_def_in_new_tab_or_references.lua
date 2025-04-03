local M = {}

local lsp_util = vim.lsp.util
local lsp_buf_request = vim.lsp.buf_request
local api = vim.api
local builtin = require('telescope.builtin')

M.lsp_def_in_new_tab_or_references = function()
  local params = lsp_util.make_position_params()
  local curr_buf = vim.api.nvim_get_current_buf()
  local curr_pos = vim.api.nvim_win_get_cursor(0)

  lsp_buf_request(0, 'textDocument/definition', params, function(err, result, ctx, _)
    if err then
      vim.notify('LSP error: ' .. err.message, vim.log.levels.ERROR)
      return
    end

    if not result or vim.tbl_isempty(result) then
      vim.notify('No definition found', vim.log.levels.INFO)
      return
    end

    -- Normalize result to always be a list
    if not vim.tbl_islist(result) then
      result = { result }
    end

    -- Check if we're already at one of the definition locations
    for _, def in ipairs(result) do
      local uri = def.uri or def.targetUri
      local range = def.range or def.targetSelectionRange
      local def_buf = vim.uri_to_bufnr(uri)
      local def_line = range.start.line
      local def_char = range.start.character

      if curr_buf == def_buf and curr_pos[1] - 1 == def_line then
        -- Already at the definition
        builtin.lsp_references()
        return
      end
    end

    vim.cmd('tab split')
    builtin.lsp_definitions()
  end)
end

return M

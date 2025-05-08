local M = {}

local function set_buffer_keymap(buf, mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, opts)
end

M.toggle_big_files_stuff = function()
  local buf = vim.api.nvim_get_current_buf()

  -- Initialize toggle state if not already
  if vim.b[buf].big_file_mode == nil then
    vim.b[buf].big_file_mode = false
  end

  -- Toggle state
  if not vim.b[buf].big_file_mode then
    -- Save current state
    vim.b[buf].original_filetype = vim.bo[buf].filetype
    -- vim.b[buf].attached_clients = vim.lsp.get_active_clients({bufnr = buf})
    vim.b[buf].attached_clients = vim.lsp.get_clients({ bufnr = buf })

    -- Disable Treesitter highlighting
    vim.cmd("TSBufDisable highlight")

    -- Clear filetype (which disables filetype plugins)
    vim.bo[buf].filetype = ''

    -- Detach all LSP clients
    for _, client in pairs(vim.b[buf].attached_clients) do
      vim.lsp.buf_detach_client(buf, client.id)
    end

    set_buffer_keymap(buf, 'n', '<C-u>', '<Nop>')
    set_buffer_keymap(buf, 'n', '<C-d>', '<Nop>')

    vim.b[buf].big_file_mode = true

    vim.notify("Big file mode ON", vim.log.levels.INFO)
  else
    -- Re-enable filetype
    vim.bo[buf].filetype = vim.b[buf].original_filetype or ''

    -- Re-enable Treesitter highlighting (only if parser exists)
    local ok = pcall(function()
      vim.cmd("TSBufEnable highlight")
    end)

    -- Reattach LSP clients
    for _, client in pairs(vim.b[buf].attached_clients or {}) do
      -- Reattach only if still active
      if client and client.name and vim.lsp.get_client_by_id(client.id) then
        vim.lsp.buf_attach_client(buf, client.id)
      end
    end

    set_buffer_keymap(buf, 'n', '<C-u>', '<C-u>')
    set_buffer_keymap(buf, 'n', '<C-d>', '<C-d>')

    vim.b[buf].big_file_mode = false
    vim.notify("Big file mode OFF", vim.log.levels.INFO)
  end
end

return M

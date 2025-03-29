local M = {}

M.smart_windows_close = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local windows = vim.fn.win_findbuf(bufnr)

  local is_modified = vim.bo[bufnr].modified
  local is_last_window = #windows == 1

  if is_modified and is_last_window then
    local choice = vim.fn.confirm("Buffer has unsaved changes. Save before closing?", "&Yes\n&No\n&Cancel", 1)
    if choice == 1 then
      vim.cmd('write')
      vim.cmd('q')
    elseif choice == 2 then
      vim.cmd('q!')
    end
  else
    vim.cmd('q')
  end
end


return M

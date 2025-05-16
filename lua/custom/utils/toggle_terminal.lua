local M = {}

M.toggle_terminal = function(location)
  if vim.bo.buftype == 'terminal' then
    vim.cmd('q')
  elseif location == 'new tab' then
    vim.cmd('tab terminal')
  else
    if location == 'horizontal' then
      vim.cmd('split')
    elseif location == 'vertical' then
      vim.cmd('vsplit')
    end
    vim.cmd('terminal')
  end
end

return M

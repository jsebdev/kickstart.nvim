vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  pattern = '*',
  command = 'checktime',
})

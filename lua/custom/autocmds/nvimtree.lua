-- Auto close nvim-tree when opening a file
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    local api = require("nvim-tree.api")
    local view = require("nvim-tree.view")
    if view.is_visible() and not api.tree.is_tree_buf() then
      api.tree.close()
      print("closing")
    end
  end
})


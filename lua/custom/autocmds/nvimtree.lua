-- Auto close nvim-tree when opening a file
-- vim.api.nvim_create_autocmd("BufEnter", {
--   nested = true,
--   callback = function(args)
--     local api = require("nvim-tree.api")
--     local view = require("nvim-tree.view")
--
--     local bufnr = args.buf
--     local filetype = vim.bo[bufnr].filetype
--     local bufname = vim.api.nvim_buf_get_name(bufnr)
--
--     -- Only close if:
--     -- 1. Tree is visible
--     -- 2. This buffer is not NvimTree or other pseudo-buffers
--     -- 3. The buffer has a real name (not like [No Name] or empty string)
--     if view.is_visible()
--       and filetype ~= "NvimTree"
--       and filetype ~= "neo-tree"
--       and filetype ~= "TelescopePrompt"
--       and bufname ~= ""
--       and not bufname:match("^%[.+%]") -- e.g. [No Name], [scratch]
--     then
--       api.tree.close()
--     end
--   end
-- })

-- Close NvimTree only when a file is opened from it
local api = require("nvim-tree.api")

api.events.subscribe(api.events.Event.FileOpened, function(file)
  api.tree.close()
end)


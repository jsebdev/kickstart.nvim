-- To get log files updated even when I'm editing them in nvim
vim.opt.backupcopy = 'yes'

-- folding settings
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = true
vim.o.foldlevel = 1

-- spell checking
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- looks
vim.api.nvim_set_hl(0, "Normal", { bg = "#111111", fg = "#bbbbcc" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#555555", fg = "#000000" })


-- suggested by avante.nvim
vim.opt.laststatus = 3


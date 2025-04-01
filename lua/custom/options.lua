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

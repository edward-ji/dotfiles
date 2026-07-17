vim.opt.exrc = true

vim.opt.guicursor = ''

vim.opt.mousemodel = 'extend'

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.shortmess:append('IS')

vim.opt.wrap = false
vim.opt.textwidth = 80
vim.opt.colorcolumn = '+1'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.spell = true
vim.opt.spelllang = 'en,cjk'

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.pyindent_open_paren = vim.o.shiftwidth

vim.g.netrw_banner = 0

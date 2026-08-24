-- Reset highlight search on escape
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Yank text
vim.keymap.set('n', '<Leader>y', '"+y', { desc = 'Yank text into clipboard' })
vim.keymap.set('v', '<Leader>y', '"+y', { desc = 'Yank text into clipboard' })
vim.keymap.set('n', 'gy', '`[v`]', { desc = 'Select the previously changed or yanked text.' })

-- Move line or selection up or down with proper indenting
vim.keymap.set('n', '<M-k>', ':move .-2<CR>==', { desc = 'Move line up', silent = true })
vim.keymap.set('n', '<M-j>', ':move .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set('v', '<M-k>', ":move '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })
vim.keymap.set('v', '<M-j>', ":move '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })

-- Buffer management
vim.keymap.set('n', '<Tab>', '<Cmd>bnext<CR>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>bprevious<CR>')

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-N>')
vim.keymap.set('t', '<C-W>h', '<Cmd>wincmd h<CR>')
vim.keymap.set('t', '<C-W>j', '<Cmd>wincmd j<CR>')
vim.keymap.set('t', '<C-W>k', '<Cmd>wincmd k<CR>')
vim.keymap.set('t', '<C-W>l', '<Cmd>wincmd l<CR>')

-- Plugin and LSP managers
vim.keymap.set('n', '<Leader>pu', function()
    vim.pack.update()
end, { desc = 'Update plugins' })
vim.keymap.set('n', '<Leader>mm', '<Cmd>Mason<CR>')

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
vim.keymap.set('n', 'gb', function()
    return '<Cmd>silent! LualineBuffersJump ' .. vim.v.count1 .. '<CR>'
end, { desc = 'Jump to buffer [count]', expr = true })
vim.keymap.set('n', '<Leader>bd', '<Cmd>bdelete<CR>')

-- Terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>h', '<Cmd>wincmd h<CR>')
vim.keymap.set('t', '<C-w>j', '<Cmd>wincmd j<CR>')
vim.keymap.set('t', '<C-w>k', '<Cmd>wincmd k<CR>')
vim.keymap.set('t', '<C-w>l', '<Cmd>wincmd l<CR>')

-- Plugin and LSP managers
vim.keymap.set('n', '<Leader>ll', '<Cmd>Lazy<CR>')
vim.keymap.set('n', '<Leader>ls', '<Cmd>Lazy sync<CR>')
vim.keymap.set('n', '<Leader>lp', '<Cmd>Lazy profile<CR>')
vim.keymap.set('n', '<Leader>mm', '<Cmd>Mason<CR>')

return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                mappings = { i = { ['<esc>'] = actions.close } },
            },
            pickers = {
                live_grep = {
                    additional_args = function(opts)
                        return { '--hidden', '-g', '!.git/*' }
                    end,
                },
            },
        })

        vim.keymap.set('n', 'z=', builtin.spell_suggest, { desc = 'Telescope spell suggest' })
        vim.keymap.set('n', '<leader>fa', function()
            builtin.find_files({
                find_command = {
                    'rg',
                    '--files',
                    '--hidden',
                    '--glob',
                    '!**/.git/*',
                },
            })
        end, { desc = 'Telescope find hidden files' })
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fd', function()
            builtin.diagnostics({ bufnr = 0 })
        end, { desc = 'Telescope current buffer diagnostics' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
    end,
}

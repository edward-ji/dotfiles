return {
    specs = {
        { src = 'https://github.com/nvim-lua/plenary.nvim' },
        {
            src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
            data = { build = { 'make' } },
        },
        {
            src = 'https://github.com/nvim-telescope/telescope.nvim',
            version = vim.version.range('*'),
        },
    },

    config = function()
        -- Every plugin is already on the runtimepath after `vim.pack.add()`, so
        -- deferring here is just delaying the `require()` until first use --
        -- telescope's modules cost ~9ms to load.
        local setup_done = false
        local function picker(name, opts)
            return function()
                if not setup_done then
                    require('telescope').setup({
                        defaults = {
                            mappings = { i = { ['<esc>'] = require('telescope.actions').close } },
                        },
                        pickers = {
                            live_grep = {
                                additional_args = function(_)
                                    return { '--hidden', '-g', '!.git/*' }
                                end,
                            },
                        },
                    })
                    setup_done = true
                end
                require('telescope.builtin')[name](opts)
            end
        end

        vim.keymap.set('n', 'z=', picker('spell_suggest'), { desc = 'Telescope spell suggest' })
        vim.keymap.set('n', '<leader>fa', picker('find_files', {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        }), { desc = 'Telescope find hidden files' })
        vim.keymap.set('n', '<leader>ff', picker('find_files'), { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', picker('live_grep'), { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', picker('buffers'), { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', picker('help_tags'), { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fd', picker('diagnostics', { bufnr = 0 }), { desc = 'Telescope current buffer diagnostics' })
        vim.keymap.set('n', '<leader>fk', picker('keymaps'), { desc = 'Telescope keymaps' })
    end,
}

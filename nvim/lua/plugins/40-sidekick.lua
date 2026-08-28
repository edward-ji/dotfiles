return {
    specs = {
        { src = 'https://github.com/folke/sidekick.nvim' },
    },

    config = function()
        require('sidekick').setup({
            cli = {
                mux = {
                    backend = 'tmux',
                    enabled = true,
                },
            },
        })

        vim.keymap.set('n', '<Tab>', function()
            -- if there is a next edit, jump to it, otherwise apply it if any
            if not require('sidekick').nes_jump_or_apply() then
                return '<Tab>' -- fallback to normal tab
            end
        end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

        vim.keymap.set({ 'n', 't', 'i', 'x' }, '<C-.>', function()
            require('sidekick.cli').focus()
        end, { desc = 'Sidekick Focus' })

        vim.keymap.set('n', '<Leader>aa', function()
            require('sidekick.cli').toggle()
        end, { desc = 'Sidekick Toggle CLI' })

        vim.keymap.set('n', '<Leader>as', function()
            require('sidekick.cli').select({ filter = { installed = true }})
        end, { desc = 'Select CLI' })

        vim.keymap.set('n', '<Leader>ad', function()
            require('sidekick.cli').close()
        end, { desc = 'Detach a CLI Session' })

        vim.keymap.set({ 'x', 'n' }, '<Leader>at', function()
            require('sidekick.cli').send({ msg = '{this}' })
        end, { desc = 'Send This' })

        vim.keymap.set('n', '<Leader>af', function()
            require('sidekick.cli').send({ msg = '{file}' })
        end, { desc = 'Send File' })

        vim.keymap.set('x', '<Leader>av', function()
            require('sidekick.cli').send({ msg = '{selection}' })
        end, { desc = 'Send Visual Selection' })

        vim.keymap.set({ 'n', 'x' }, '<Leader>ap', function()
            require('sidekick.cli').prompt()
        end, { desc = 'Sidekick Select Prompt' })
    end,
}

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

        -- Show each session's tmux pane title in the CLI attach picker
        local select_ui = require('sidekick.cli.ui.select')
        local util = require('sidekick.util')
        local base_format = select_ui.format
        local pane_fmt = '#{pane_id}\t#{pane_title}'
        local host = vim.fn.hostname()

        local titles, titles_at = {}, 0
        local function pane_title(pane_id)
            if vim.uv.now() - titles_at > 2000 then
                titles, titles_at = {}, vim.uv.now()
                local cmd = { 'tmux', 'list-panes', '-a', '-F', pane_fmt }
                local lines = util.exec(cmd, { notify = false }) or {}
                for _, line in ipairs(lines) do
                    local id, title = line:match('^(%%%d+)\t(.*)$')
                    if id and title ~= '' and title ~= host then
                        titles[id] = title
                    end
                end
            end
            return titles[pane_id]
        end

        function select_ui.format(state, picker)
            local parts = base_format(state, picker)
            local s = state.session or {}
            local pane_id = s.tmux_pane_id
                or (s.parent and s.parent.tmux_pane_id)
            local title = pane_id and pane_title(pane_id)
            if title then
                parts[#parts + 1] = { '  ' }
                parts[#parts + 1] = { title, 'Comment' }
            end
            return parts
        end
    end,
}

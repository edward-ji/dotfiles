return {
    specs = {
        { src = 'https://github.com/folke/snacks.nvim' },
    },

    config = function()
        require('snacks').setup({
            picker = {
                enabled = true,
                win = {
                    input = {
                        keys = {
                            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
                        },
                    },
                },
            },
        })

        -- Top pickers
        vim.keymap.set('n', '<Leader><Space>', function() Snacks.picker.smart() end, { desc = 'Snacks smart find files' })
        vim.keymap.set('n', '<Leader>,', function() Snacks.picker.buffers() end, { desc = 'Snacks buffers' })
        vim.keymap.set('n', '<Leader>/', function() Snacks.picker.grep({ hidden = true }) end, { desc = 'Snacks grep' })
        vim.keymap.set('n', '<Leader>:', function() Snacks.picker.command_history() end, { desc = 'Snacks command history' })

        vim.keymap.set('n', 'z=', function() Snacks.picker.spelling() end, { desc = 'Snacks spell suggest' })

        -- Find
        vim.keymap.set('n', '<Leader>fa', function() Snacks.picker.files({ hidden = true }) end, { desc = 'Snacks find hidden files' })
        vim.keymap.set('n', '<Leader>fb', function() Snacks.picker.buffers() end, { desc = 'Snacks buffers' })
        vim.keymap.set('n', '<Leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, { desc = 'Snacks find config file' })
        vim.keymap.set('n', '<Leader>ff', function() Snacks.picker.files() end, { desc = 'Snacks find files' })
        vim.keymap.set('n', '<Leader>fg', function() Snacks.picker.git_files() end, { desc = 'Snacks find git files' })
        vim.keymap.set('n', '<Leader>fp', function() Snacks.picker.projects() end, { desc = 'Snacks projects' })
        vim.keymap.set('n', '<Leader>fr', function() Snacks.picker.recent() end, { desc = 'Snacks recent files' })
        vim.keymap.set('n', '<Leader>fz', function() Snacks.picker.zoxide() end, { desc = 'Snacks zoxide directories' })

        -- Git
        vim.keymap.set('n', '<Leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Snacks git branches' })
        vim.keymap.set('n', '<Leader>gl', function() Snacks.picker.git_log() end, { desc = 'Snacks git log' })
        vim.keymap.set('n', '<Leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Snacks git log line' })
        vim.keymap.set('n', '<Leader>gs', function() Snacks.picker.git_status() end, { desc = 'Snacks git status' })
        vim.keymap.set('n', '<Leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Snacks git stash' })
        vim.keymap.set('n', '<Leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Snacks git diff (hunks)' })
        vim.keymap.set('n', '<Leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Snacks git log file' })

        -- Grep
        vim.keymap.set('n', '<Leader>sb', function() Snacks.picker.lines() end, { desc = 'Snacks buffer lines' })
        vim.keymap.set('n', '<Leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Snacks grep open buffers' })
        vim.keymap.set('n', '<Leader>sg', function() Snacks.picker.grep({ hidden = true }) end, { desc = 'Snacks grep' })
        vim.keymap.set({ 'n', 'x' }, '<Leader>sw', function() Snacks.picker.grep_word({ hidden = true }) end, { desc = 'Snacks grep word or selection' })

        -- Search
        vim.keymap.set('n', '<Leader>s"', function() Snacks.picker.registers() end, { desc = 'Snacks registers' })
        vim.keymap.set('n', '<Leader>s/', function() Snacks.picker.search_history() end, { desc = 'Snacks search history' })
        vim.keymap.set('n', '<Leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Snacks autocmds' })
        vim.keymap.set('n', '<Leader>sc', function() Snacks.picker.command_history() end, { desc = 'Snacks command history' })
        vim.keymap.set('n', '<Leader>sC', function() Snacks.picker.commands() end, { desc = 'Snacks commands' })
        vim.keymap.set('n', '<Leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Snacks workspace diagnostics' })
        vim.keymap.set('n', '<Leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Snacks buffer diagnostics' })
        vim.keymap.set('n', '<Leader>sh', function() Snacks.picker.help() end, { desc = 'Snacks help pages' })
        vim.keymap.set('n', '<Leader>sH', function() Snacks.picker.highlights() end, { desc = 'Snacks highlights' })
        vim.keymap.set('n', '<Leader>si', function() Snacks.picker.icons() end, { desc = 'Snacks icons' })
        vim.keymap.set('n', '<Leader>sj', function() Snacks.picker.jumps() end, { desc = 'Snacks jumps' })
        vim.keymap.set('n', '<Leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Snacks keymaps' })
        vim.keymap.set('n', '<Leader>sl', function() Snacks.picker.loclist() end, { desc = 'Snacks location list' })
        vim.keymap.set('n', '<Leader>sm', function() Snacks.picker.marks() end, { desc = 'Snacks marks' })
        vim.keymap.set('n', '<Leader>sM', function() Snacks.picker.man() end, { desc = 'Snacks man pages' })
        vim.keymap.set('n', '<Leader>sq', function() Snacks.picker.qflist() end, { desc = 'Snacks quickfix list' })
        vim.keymap.set('n', '<Leader>sR', function() Snacks.picker.resume() end, { desc = 'Snacks resume last picker' })
        vim.keymap.set('n', '<Leader>su', function() Snacks.picker.undo() end, { desc = 'Snacks undo history' })
        vim.keymap.set('n', '<Leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Snacks colorschemes' })

        -- LSP
        -- `gr` is left unmapped: it would be a prefix of Neovim's own default
        -- gr*-prefixed LSP keymaps (grr, gra, gri, grn), so Neovim would wait
        -- out timeoutlen on every gr* keymap to see if more input is coming.
        -- `gy` is left unmapped: it already selects the last changed or
        -- yanked text (see eji/mapping.lua).
        vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto definition' })
        vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto declaration' })
        vim.keymap.set('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto implementation' })
        vim.keymap.set('n', 'gai', function() Snacks.picker.lsp_incoming_calls() end, { desc = 'Calls incoming' })
        vim.keymap.set('n', 'gao', function() Snacks.picker.lsp_outgoing_calls() end, { desc = 'Calls outgoing' })
        vim.keymap.set('n', '<Leader>ss', function() Snacks.picker.lsp_symbols() end, { desc = 'Snacks document symbols' })
        vim.keymap.set('n', '<Leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, { desc = 'Snacks workspace symbols' })

        -- Other
        vim.keymap.set('n', '<Leader>bd', function() Snacks.bufdelete() end, { desc = 'Snacks delete buffer' })
        vim.keymap.set('n', '<Leader>z', function() Snacks.zen() end, { desc = 'Snacks toggle zen mode' })
        vim.keymap.set('n', '<Leader>Z', function() Snacks.zen.zoom() end, { desc = 'Snacks toggle zoom' })
        vim.keymap.set('n', '<Leader>.', function() Snacks.scratch() end, { desc = 'Snacks toggle scratch buffer' })
        vim.keymap.set('n', '<Leader>S', function() Snacks.scratch.select() end, { desc = 'Snacks select scratch buffer' })
        vim.keymap.set('n', '<Leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Snacks rename file' })
        vim.keymap.set({ 'n', 'v' }, '<Leader>gB', function() Snacks.gitbrowse() end, { desc = 'Snacks git browse' })
        vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Snacks toggle terminal' })

        -- Toggles
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<Leader>us')
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<Leader>uw')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<Leader>uL')
        Snacks.toggle.diagnostics():map('<Leader>ud')
        Snacks.toggle.line_number():map('<Leader>ul')
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<Leader>uc')
        Snacks.toggle.treesitter():map('<Leader>uT')
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<Leader>ub')
        Snacks.toggle.inlay_hints():map('<Leader>uh')
    end,
}

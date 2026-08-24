return {
    specs = {
        { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    },

    config = function()
        require('gitsigns').setup({
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<Leader>hs', gs.stage_hunk)
                map('n', '<Leader>hr', gs.reset_hunk)
                map('v', '<Leader>hs', function()
                    gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)
                map('v', '<Leader>hr', function()
                    gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)
                map('n', '<Leader>hS', gs.stage_buffer)
                map('n', '<Leader>hu', gs.undo_stage_hunk)
                map('n', '<Leader>hR', gs.reset_buffer)
                map('n', '<Leader>hp', gs.preview_hunk)
                map('n', '<Leader>hi', gs.preview_hunk_inline)
                map('n', '<Leader>hb', function()
                    gs.blame_line({ full = true })
                end)
                map('n', '<Leader>hd', gs.diffthis)
                map('n', '<Leader>hD', function()
                    gs.diffthis('~')
                end)
                map('n', '<Leader>hQ', function()
                    gs.setqflist('all')
                end)
                map('n', '<Leader>hq', gs.setqflist)

                -- Toggles
                map('n', '<Leader>tb', gs.toggle_current_line_blame)
                map('n', '<Leader>tw', gs.toggle_word_diff)
                map('n', '<Leader>td', gs.toggle_deleted)

                -- Text object
                map({ 'o', 'x' }, 'ih', gs.select_hunk)
            end,
        })
    end,
}

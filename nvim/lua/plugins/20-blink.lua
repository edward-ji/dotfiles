return {
    specs = {
        {
            src = 'https://github.com/saghen/blink.cmp',
            version = vim.version.range('1.*'),
        },
        { src = 'https://github.com/rafamadriz/friendly-snippets' },
    },

    config = function()
        local function has_words_before()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            if col == 0 then
                return false
            end
            return vim.api.nvim_get_current_line():sub(col, col):match('%s') == nil
        end

        require('blink.cmp').setup({
            keymap = {
                preset = 'default',
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-Space>'] = false,
                ['<M-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<Tab>'] = {
                    'select_next',
                    'snippet_forward',
                    function(cmp)
                        if has_words_before() then
                            cmp.show()
                            return true
                        end
                    end,
                    'fallback',
                },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },
            completion = {
                documentation = { auto_show = true },
                list = { selection = { preselect = true, auto_insert = false } },
            },
        })

        vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
    end,
}

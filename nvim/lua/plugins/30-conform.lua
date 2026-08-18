return {
    specs = {
        { src = 'https://github.com/stevearc/conform.nvim' },
    },

    config = function()
        require('conform').setup({
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
                tex = { 'tex-fmt' },
            },
        })

        vim.keymap.set('', '<Leader>f', function()
            require('conform').format({ async = true, lsp_fallback = true })
        end, { desc = 'Format buffer' })
    end,
}

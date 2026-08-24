return {
    specs = {
        { src = 'https://github.com/stevearc/conform.nvim' },
    },

    config = function()
        require('conform').setup({
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
            },
        })

        vim.keymap.set('', '<Leader>cf', function()
            require('conform').format({ async = true, lsp_format = 'fallback' })
        end, { desc = 'Format buffer' })
    end,
}

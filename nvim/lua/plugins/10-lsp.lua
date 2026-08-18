return {
    specs = {
        { src = 'https://github.com/mason-org/mason.nvim' },
        { src = 'https://github.com/neovim/nvim-lspconfig' },
        { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    },

    config = function()
        require('mason').setup()
        -- Defaults to `automatic_enable`, which calls vim.lsp.enable() for
        -- every server installed through Mason.
        require('mason-lspconfig').setup()
    end,
}

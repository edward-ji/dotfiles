return {
    specs = {
        { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
    },

    config = function()
        require('catppuccin').setup({
            flavour = 'mocha',
            no_italic = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                snacks = true,
            },
        })
        vim.cmd.colorscheme('catppuccin')
    end,
}

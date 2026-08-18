return {
    specs = {
        { src = 'https://github.com/danymat/neogen' },
    },

    config = function()
        require('neogen').setup({
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = 'reST',
                    },
                },
            },
        })

        vim.keymap.set('n', '<Leader>nf', function()
            require('neogen').generate()
        end, { desc = 'Neogen generate' })
    end,
}

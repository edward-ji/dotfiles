return {
    'tpope/vim-fugitive',

    {
        'wakatime/vim-wakatime',
        enabled = os.getenv('NO_ASKPASS') == nil,
    },

    {
        'nmac427/guess-indent.nvim',
        config = true,
    },

    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
}

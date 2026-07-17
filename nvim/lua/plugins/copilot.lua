return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup({
            panel = {
                layout = {
                    position = 'right',
                },
            },
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept_word = '<M-Right>',
                    accept_line = '<C-M-Right>',
                },
            },
        })
    end,
    enabled = os.getenv('NO_ASKPASS') == nil,
}

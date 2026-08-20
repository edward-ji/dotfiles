local indent = {
    function()
        local expand = vim.bo.expandtab and '󱁐' or '󰌒'
        local width = vim.fn.shiftwidth()
        return expand .. ' ' .. width
    end,
    cond = function()
        return vim.bo.filetype ~= ''
    end,
}

return {
    specs = {
        { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
        { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    },

    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
                globalstatus = true,
                refresh = {
                    statusline = 250,
                    tabline = 250,
                    winbar = 250,
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    { 'branch', icon = '' },
                    'diff',
                    'diagnostics',
                },
                lualine_c = { 'filename' },
                lualine_x = {
                    indent,
                    'encoding',
                    {
                        'fileformat',
                        icons_enabled = false,
                        fmt = function(str)
                            local tbl = {
                                unix = 'LF',
                                dos = 'CRLF',
                                mac = 'CR',
                            }
                            return tbl[str]
                        end,
                    },
                    'filetype',
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
            tabline = {
                lualine_a = {
                    {
                        'buffers',
                        mode = 2,
                        max_length = vim.o.columns * 2 / 3,
                        filetype_names = {
                            snacks_picker_input = 'Snacks',
                            fugitive = 'Fugitive',
                            mason = 'Mason',
                        },
                        symbols = {
                            modified = ' +',
                        },
                    },
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {
                    {
                        'tabs',
                        max_length = vim.o.columns / 3,
                    },
                },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {
                    {
                        'searchcount',
                        fmt = function(string, _)
                            if string ~= '' then
                                return vim.fn.getreg('/') .. ' ' .. string
                            end
                            return ''
                        end,
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}

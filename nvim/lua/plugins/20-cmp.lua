return {
    specs = {
        { src = 'https://github.com/rafamadriz/friendly-snippets' },
        {
            src = 'https://github.com/L3MON4D3/LuaSnip',
            version = vim.version.range('2.*'),
            data = { build = { 'make', 'install_jsregexp' } },
        },
        { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
        { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
        { src = 'https://github.com/hrsh7th/cmp-buffer' },
        { src = 'https://github.com/hrsh7th/cmp-path' },
        { src = 'https://github.com/hrsh7th/cmp-cmdline' },
        { src = 'https://github.com/hrsh7th/nvim-cmp' },
    },

    config = function()
        -- LuaSnip + cmp cost ~20ms to require; defer to the first insert, which
        -- is the trigger this used under lazy.nvim.
        vim.api.nvim_create_autocmd('InsertEnter', {
            once = true,
            callback = function()
                require('luasnip.loaders.from_vscode').lazy_load()

                local has_words_before = function()
                    unpack = unpack or table.unpack
                    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
                end

                local luasnip = require('luasnip')
                local cmp = require('cmp')

                cmp.setup({
                    sources = {
                        { name = 'buffer' },
                        { name = 'path' },
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<CR>'] = cmp.mapping.confirm({ select = false }),
                        ['<M-Space>'] = cmp.mapping.complete(),
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            elseif has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),

                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                    }),
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body)
                        end,
                    },
                })
            end,
        })
    end,
}

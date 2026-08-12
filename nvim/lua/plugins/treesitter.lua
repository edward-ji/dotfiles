return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        local function start_highlight(buf)
            if pcall(vim.treesitter.start, buf) then
                vim.bo[buf].syntax = ''
            end
        end

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf = args.buf
                local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
                if not lang or not vim.tbl_contains(require('nvim-treesitter').get_available(), lang) then
                    return
                end

                if not vim.tbl_contains(require('nvim-treesitter').get_installed('parsers'), lang) then
                    require('nvim-treesitter').install(lang):await(function(err)
                        if err or not vim.api.nvim_buf_is_valid(buf) then
                            return
                        end
                        vim.schedule(function()
                            start_highlight(buf)
                        end)
                    end)
                    return
                end

                start_highlight(buf)
            end,
        })
    end,
}

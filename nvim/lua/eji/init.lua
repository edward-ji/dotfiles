require('eji.mapping')
require('eji.options')

-- Load local config if it exists (user-specific, not in repo)
local local_config = vim.fn.stdpath('config') .. '/lua/eji/local.lua'
if vim.fn.filereadable(local_config) == 1 then
    require('eji.local')
end

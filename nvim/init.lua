require('eji')

local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'

-- Build hooks. Registered before the first `vim.pack.add()` so they also fire
-- on the initial install. Each spec carries its own command in `data.build`,
-- either an argv table run in the plugin's directory or a function.
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local data = ev.data
        if data.kind ~= 'install' and data.kind ~= 'update' then
            return
        end

        local build = vim.tbl_get(data, 'spec', 'data', 'build')
        if type(build) == 'function' then
            build(data)
        elseif build then
            vim.system(build, { cwd = data.path }):wait()
        end
    end,
})

-- Collect specs from every `lua/plugins/*.lua`, gitignored `*.local.lua`
-- overrides included. `loadfile` rather than `require` because a dotted local
-- filename is not addressable as a module name.
local files = {}
for name, kind in vim.fs.dir(plugins_dir) do
    if kind == 'file' and name:match('%.lua$') then
        table.insert(files, name)
    end
end
table.sort(files)

local specs, configs = {}, {}
for _, name in ipairs(files) do
    local module = assert(loadfile(plugins_dir .. '/' .. name))()
    vim.list_extend(specs, module.specs or {})
    if module.config then
        table.insert(configs, module.config)
    end
end

-- One `add()` puts every plugin on the runtimepath before any config runs, so
-- dependencies need no ordering. Only genuine config-time ordering is encoded
-- in the `NN-` filename prefixes (the colorscheme must precede lualine, which
-- reads it via `theme = 'auto'`).
vim.pack.add(specs, { confirm = false })

for _, config in ipairs(configs) do
    config()
end

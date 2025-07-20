return {
    settings = {
        texlab = {
            forwardSearch = {
                executable = '/Applications/Skim.app/Contents/SharedSupport/displayline',
                args = { '-n', '-g', '%l', '%p', '%f' },
            },
            build = {
                forwardSearchAfter = true,
                onSave = true,
            },
        },
    }
}

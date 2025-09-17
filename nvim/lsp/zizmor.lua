return {
    cmd = { 'zizmor',  '--lsp' },
    filetypes = { 'yaml' },
    root_markers = { '.github', '.git', '.jj' },

    capabilities = {
        textDocument = {
            didOpen = { dynamicRegistration = true },
            didChange = { dynamicRegistration = true },
            didSave = { dynamicRegistration = true },
            didClose = { dynamicRegistration = true },
        },
        workspace = {
            didChangeConfiguration = { dynamicRegistration = true },
        },
    }
}

return {
    root_markers = { '.git', '.jj', 'Chart.yaml' },

    capabilities = {
        workspace = {
            didChangeConfiguration = {
                dynamicRegistration = true
            }
        }
    }
}

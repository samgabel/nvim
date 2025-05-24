return {
    settings = {
        ['helm_ls'] = {
            logLevel = "info",
            valuesFiles = {
                mainValuesFile = "values.yaml",
                lintOverlayValuesFile = "values.lint.yaml",
                additionalValuesFilesGlobPattern = "values*.yaml"
            },
            yamlls = {
                enabled = false
            }
        }
    }
}

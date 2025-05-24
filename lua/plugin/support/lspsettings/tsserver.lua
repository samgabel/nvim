-- disable all suggestions or just a specific code -> ( https://stackoverflow.com/a/70294761 )
-- alternatively we can just name our .js files .cjs -> ( https://stackoverflow.com/a/73436957 )

return {
    -- init_options = {
    --     preferences = {
    --         disableSuggestions = true,
    --     }
    -- }
    root_dir = require("lspconfig.util").root_pattern(".git")
}

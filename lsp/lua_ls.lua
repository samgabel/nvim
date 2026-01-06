-- https://luals.github.io/wiki/settings/
return {
    -- setup = {
    --     require("neodev").setup({})
    -- },
    settings = {
        Lua = {
            format = {
                enable = false,
            },
            diagnostics = {
                globals = { "vim", "spec" },
            },
            runtime = {
                version = "LuaJIT",
                special = {
                    spec = "require",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.stdpath "config" .. "/lua"] = true,
                },
            },
            hint = {
                -- enable for inlayHints
                enable = true,
                arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
                await = true,
                paramName = "Disable", -- "All" | "Literal" | "Disable"
                paramType = true,
                semicolon = "All", -- "All" | "SameLine" | "Disable"
                setType = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

local lang_utils = require("user.lang-utils")

return {



-- ========================================================================================
-- MASON -> LANGUAGE UTILS INSTALLATION
-- installs all lang_utils and creates interface between mason and lspconfig language server names
-- ========================================================================================
    {
        {
            "mason-org/mason-lspconfig.nvim",
            event = "VeryLazy",
            dependencies = {
                "mason-org/mason.nvim",
            },
            config = function()
                require("mason-lspconfig").setup({
                    -- Install all language servers
                    ensure_installed = lang_utils.servers
                })
            end
        },
        {
            "mason-org/mason.nvim",
            lazy = true,
            config = function()
                require("mason").setup({
                    ui = { border = "rounded" }
                })
                -- Install additional tooling
                local registry = require("mason-registry")
                local tools = vim.iter({ lang_utils.linters, lang_utils.formatters, lang_utils.daps }):flatten():totable()
                registry.refresh(function()
                    for _, tool in ipairs(tools) do
                        local pkg = registry.get_package(tool)
                        if not pkg:is_installed() then
                            pkg:install()
                        end
                    end
                end)
            end
        },
    },



-- ========================================================================================
-- LSPCONFIG -> NVIM LANGUAGE SERVER SETUP
-- ========================================================================================
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile", "StdinReadPre" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim"
        },
        config = function()
            local on_attach = function(client, bufnr)
            end
            -- Diagnostic Config
            vim.diagnostic.config({
                underline = true,
                virtual_lines = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
                severity_sort = true,
            })
            -- All Server Config
            -- * specific server config is in /lsp
            local cfg = {
                on_attach = on_attach,
            }
            vim.lsp.config("*", cfg)
        end
    },



}

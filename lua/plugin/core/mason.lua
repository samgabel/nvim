local M = {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
    },
}

function M.config()

    -- DECLARE PACKAGES --------------------------------------------------------------

    -- SERVER list --
    local servers = {
        "lua_ls",
        "pyright",
        "tsserver",
        "rust_analyzer",
        "gopls",
        "clangd",
        "html",
        "cssls",
        "bashls",
        "helm_ls",
        "yamlls",
        "jsonls",
        "dockerls",
        "terraformls",
        "prismals",
    }
    -- DAP list --
    local daps = {
        "debugpy",
        -- javascript uses the "microsoft/vscode-js-debug" in support/dapsettings/dap-js.lua
        "delve",
        "codelldb"
    }
    -- LINTER list --
    local linters = {
        -- "shellcheck",  <-- issue continually stacking `shellcheck` processes when entering .sh file
        -- "ansible-lint",  <-- currently a piece of doodoo
        "golangci-lint",
    }
    -- FORMATTER list --
    local formatters = {
        "black",        -- python
        "gomodifytags", -- go
        "stylua",       -- lua
        "prettier",     -- combo
        "clang-format", -- clang
    }


    -- MASON General Config
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }


    -- INSTALLING PACKAGES ----------------------------------------------------------

    -- MASON LSP Config [install]
    require("mason-lspconfig").setup {
        ensure_installed = servers
    }

    -- Concatenate tooling lists
    local registry = require "mason-registry"
    local tools = vim.tbl_flatten { linters, formatters, daps }

    -- MASON Tooling [install]
    registry.refresh(function ()
        for _, tool in ipairs(tools) do
            local pkg = registry.get_package(tool)
            if not pkg:is_installed() then
                pkg:install()
            end
        end
    end)


end

return M

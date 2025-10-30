local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "StdinReadPre" },
    dependencies = {
        {
            "folke/neodev.nvim",
            "williamboman/mason-lspconfig.nvim",
            "danymat/neogen"
        },
    },
}

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap(bufnr, "n", "gci", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
    keymap(bufnr, "n", "gco", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)
end

-- NOTE: lsp textDocument/inlayHint
-- it should be noted that inlayHint is only available for nvim --version v0.10.0-dev-e85e7fc and after
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

    -- if client.supports_method "textDocument/inlayHint" then
    --     vim.lsp.inlay_hint.enable(bufnr, true)
    -- end
end

function M.common_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
end

M.toggle_inlay_hints = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
end

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action", mode = { "n", "v" } },
        ["<leader>ld"] = { function() vim.lsp.stop_client(vim.lsp.get_active_clients()) require("null-ls").disable({}) end, "Disable" },
        ["<leader>le"] = { function() vim.cmd("LspStart") require("null-ls").enable({}) end, "Enable" },
        ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>", "Format", },
        ["<leader>li"] = { "<cmd>LspInfo<cr>", "Info" },
        ["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        ["<leader>lh"] = { "<cmd>lua require('plugin/lspconfig').toggle_inlay_hints()<cr>", "Hints" },
        ["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
        ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        -- ["<leader>lq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        ["<leader>lq"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Quickfix" },
        ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    }
    wk.register {
        ["g"] = {
            name = "LSP [G]o",
            D = { "Declaration" },
            d = { "Definition" },
            r = { "References" },
            l = { "Diagnostics" },
            I = { "Implementations" },
            ["c"] = {
                name = "Calls",
                i = { "Incoming" },
                o = { "Outgoing" }
            }
        },
        ["K"] = { "LSP document" },
    }

    local lspconfig = require "lspconfig"
    local icons = require "user.icons"

    local servers = {
        "lua_ls",
        "pyright",
        "tsserver",
        "rust_analyzer",
        "gopls",
        "clangd",
        "zls",
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

    -- (CUSTOMIZE) ICONS & VIRTUAL TEXT & DIAGNOSTIC FLOAT ----------------------------------------------

    -- [CONFIG] ----------------
    local default_diagnostic_config = {
        signs = {
            active = true,
            values = {
                { name = "DiagnosticSignError", text = icons.diagnostics.Error },
                { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
                { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
                { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
            },
        },
        virtual_text = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    -- [SETUP] ----------------
    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    -- Handled by noice.nvim --
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    -- vim.lsp.handlers["textDocument/signatureHelp"] =
        -- vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    for _, server in pairs(servers) do
        local opts = {
            on_attach = M.on_attach,
            capabilities = M.common_capabilities(),
        }

        -- Server Specific Setups --
        -- see `plugin/lspsettings` for individual language server options
        -- make sure we are not calling "setup" again in the lspsetting config files

        local require_ok, settings = pcall(require, "plugin/support/lspsettings." .. server)
        if require_ok then
            opts = vim.tbl_deep_extend("force", settings, opts)
        end

        lspconfig[server].setup(opts)
    end
end

return M

local M = {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

function M.config()
    local null_ls = require "null-ls"

    require("which-key").register({
        prefix = "<leader>",
        l = {
            n = {
                name = "null-ls",
                e = { function() require("null-ls").enable({}) end, "Enable" },
                d = { "<CMD>NullLsStop<CR>", "Disable" },
                i = { "<CMD>NullLsInfo<CR>", "Info" }
            },
        },
    })

    -- Border color settings
    local float_border_hl = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
    vim.api.nvim_set_hl(0, "NullLsInfoBorder", { fg = float_border_hl.fg })

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup {
        debug = false,
        sources = {
            formatting.stylua,
            -- formatting.prettier,
            -- formatting.prettier.with {
            --     extra_filetypes = { "toml", "yaml" },
            --     extra_args = { "--tab-width 2", "--no-semi", "--single-quote", "--jsx-single-quote" },
            -- },

        -- PYTHON --
            formatting.black,
            -- diagnostics (lspconfig) -> pyright

        -- JAVASCRIPT --
            -- formatting.eslint,

        -- GO --
            diagnostics.golangci_lint,
            code_actions.gomodifytags

        -- SHELL --
            -- formatting (lspconfig) -> bashls
            -- diagnostics (lspconfig) -> bashls

        -- ANSIBLE --
            -- formatting (lspconfig) -> ansiblels (not using ansible-line bc it's wack)
            -- diagnostics (lspconfig) -> ansiblels (not using ansible-line bc it's wack)

            -- null_ls.builtins.completion.spell,
        },

        border = "rounded"
    }
end


return M

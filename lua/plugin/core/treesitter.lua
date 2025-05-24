local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}

function M.config()

    require("nvim-dap-repl-highlights").setup()

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "vimdoc",
            "markdown",
            "markdown_inline",
            "dap_repl",
            -- WEB
            "html",
            "css",
            -- CONFIG
            "json",
            "yaml",
            "toml",
            "dockerfile",
            "terraform",
            "make",
            "gomod",
            "gosum",
            "gowork",
            "ssh_config",
            "prisma",
            -- PROGRAMMING
            "bash",
            "lua",
            "python",
            "go",
            "cpp",
            "javascript",
            "typescript",
            "rust",
            "sql",
        },
        highlight = { enable = true },
        indent = {
            enable = true,
            disable = { "yaml" }
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-n>",
                node_incremental = "<C-n>",
                scope_incremental = false,
                node_decremental = "<C-p>",
            }
        }
    }

end

return M

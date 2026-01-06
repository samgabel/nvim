return {
    -- LANGUAGE parsers --
    treesitters = {
        "vimdoc",
        "markdown",
        "markdown_inline",
        -- config
        "dockerfile",
        "gomod",
        "gosum",
        "gowork",
        "jinja",
        "json",
        "make",
        "prisma",
        "ssh_config",
        "terraform",
        "toml",
        "yaml",
        -- programming
        "bash",
        "cpp",
        "css",
        "go",
        "html",
        "javascript",
        "lua",
        "python",
        "rust",
        "sql",
        "typescript"
    },
    -- SERVER list --
    servers = {
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "gopls",
        "helm_ls",
        "html",
        "jsonls",
        "lua_ls",
        "prismals",
        "pyright",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "yamlls",
        "zls",
    },
    -- DAP list --
    daps = {
        "codelldb",
        "debugpy",
        "delve",
    },
    -- LINTER list --
    linters = {
        -- "shellcheck",  <-- issue continually stacking `shellcheck` processes when entering .sh file
        -- "ansible-lint",  <-- currently a piece of doodoo
        "golangci-lint",
    },
    -- FORMATTER list --
    formatters = {
        "black",        -- python
        "clang-format", -- clang
        "gomodifytags", -- go
        "prettier",     -- combo
        "stylua",       -- lua
    }
}

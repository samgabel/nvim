local M = {
    "folke/snacks.nvim",
    lazy = false
}

function M.config()

    require("which-key").register({
        prefix = "<leader>",
        g = {
            g = { function() require("snacks").lazygit.open() end, "Lazygit" },
            f = { function() require("snacks").lazygit.log_file() end, "File Log"}
        },
    })

    require("snacks").setup({
        lazygit = {
            configure = true,
        },
        terminal = {
            enabled = true,
        }
    })

end

return M

local M = {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
}

function M.config()
    require("ibl").setup ({
        indent = {
            char = "▎",
        },
        scope = {
            enabled = false
        }
    })
end

return M

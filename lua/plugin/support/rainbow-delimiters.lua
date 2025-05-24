local M = {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
}

function M.config()
    require("rainbow-delimiters.setup").setup {}
end

return M

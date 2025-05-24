local M = {
    "topaxi/gh-actions.nvim",
    event = "VeryLazy",
    -- make sure `yq` is intalled on $PATH
}


function M.config()
    require("gh-actions").setup()
end


return M

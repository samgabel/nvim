local M = {
    "michaelb/sniprun",
    -- event = "VeryLazy",
    branch = "master",
    build = "sh install.sh 1",
}

function M.setup()
    require("sniprun").setup {
        display = {
            "VirtualTextOk",
        },
    }
end

return M

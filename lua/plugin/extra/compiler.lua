local M = {
    "Zeioth/compiler.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "stevearc/overseer.nvim",
            commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
            cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
            opts = {
                task_list = {
                    direction = "bottom",
                    min_height = 25,
                    max_height = 25,
                    default_detail = 1
                }
            }
        },
        {
            "nvim-telescope/telescope.nvim"
        }
    },
}


function M.config()

    require("which-key").register({
        prefix = "<leader>",
        c = {
            e = { "<cmd>CompilerOpen<cr>", "Open" },
            o = { "<cmd>CompilerToggleResults<cr><C-w>k", "Toggle" },
            c = { "<cmd>CompilerRedo<cr>", "Redo"},
            q = { "<cmd>CompilerToggleResults<cr><cmd>CompilerStop<cr>", "Stop"}
        },
    })

    require("compiler").setup()
end


return M

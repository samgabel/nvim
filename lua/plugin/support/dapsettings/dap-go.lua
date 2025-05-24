local M = {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    }
}

function M.config()

    require("which-key").register({
        prefix = "<leader>",
        d = {
            g = {
                name = "Go",
                r = { function() require('dap-go').debug_test() end, "Test Method" },
            },
        },
    })

    require("dap-go").setup({
        delve = {
            path = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv"
        }
    })

end

return M


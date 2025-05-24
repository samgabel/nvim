local M = {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    }
}

function M.config()

    require("which-key").register({
        prefix = "<leader>",
        d = {
            p = {
                name = "Python",
                r = { function() require("dap-python").test_method() end, "Test Method" },
            },
        },
    })

    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)

end

return M

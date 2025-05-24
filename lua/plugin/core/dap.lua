local M = {
    "mfussenegger/nvim-dap",
    lazy = true,
}

function M.config()

    require("which-key").register({
        ["<leader>dp"] = { "<CMD>lua require('dapui').eval()<CR><CMD>lua require('dapui').eval()<CR>", "Expression Float" },
        ["<leader>db"] = { "<CMD>DapToggleBreakpoint<CR>", "Breakpoint" },
        ["<leader>dB"] = { function() require('dap').set_breakpoint(vim.fn.input('Condition: '), nil, nil) end, "Conditional Breakpoint" },
        ["<leader>dc"] = { "<CMD>DapContinue<CR>", "Continue" },
        ["<leader>do"] = { "<CMD>DapStepOver<CR>", "Step Over" },
        ["<leader>di"] = { "<CMD>DapStepInto<CR>", "Step Into" },
        ["<leader>dO"] = { "<CMD>DapStepOut<CR>", "Step Out" },
        ["<leader>dq"] = { "<CMD>DapTerminate<CR>", "Quit" },
    })

end

-- change breakpoint symbol
local sign = vim.fn.sign_define
sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})

return M


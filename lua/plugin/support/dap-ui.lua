local M = {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
        {
            "mfussenegger/nvim-dap",
            "LiadOz/nvim-dap-repl-highlights",
        },
    }
}

function M.config()

    ---@diagnostic disable-next-line: missing-fields
    require("dapui").setup({
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.35 },
                    { id = "breakpoints", size = 0.15 },
                    { id = "stacks", size = 0.15 },
                    { id = "watches", size = 0.35 },
                },
                position = "right",
                size = 0.01
            },
            {
                elements = {
                    { id = "repl", size = 0.5 },
                    -- { id = "console", size = 0.5 }
                },
                position = "bottom",
                size = 8
            }
        },
        mappings = {
            expand = { "<CR>", "f" },
        },
    })

    local neotest = require("neotest")

    -- DAP UI EVENTS
    local dap, dapui = require("dap"), require("dapui")
    -- dap.listeners.before.attach.dapui_config = function()
    --     dapui.open()
    -- end
    dap.listeners.before.launch.dapui_config = function()
        neotest.summary.close()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        -- neotest.summary.open()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    -- TODO: Fix THIS!!!!!!









    local dap = require("dap")

    -- C
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" }
        }
    }

    dap.configurations.c = {
        {
            name = 'Launch',
            type = 'codelldb',
            request = 'launch',
            program = function() -- Ask the user what executable wants to debug
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/bin/program', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        },
    }








end

return M


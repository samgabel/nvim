local M = {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- "mfussenegger/nvim-dap", -- need to implement for <leader>td to work
        -- general tests
        "vim-test/vim-test",
        "nvim-neotest/neotest-vim-test",
        -- language specific tests
        "marilari88/neotest-vitest",
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go",
        "nvim-neotest/neotest-plenary",
        "rouge8/neotest-rust",
        "lawrence-laz/neotest-zig",
        "rcasia/neotest-bash",
    },
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>te"] = { "<cmd>lua require'neotest'.summary.toggle()<cr>", "Summary" },
        ["<leader>to"] = { "<cmd>lua require'neotest'.output_panel.toggle()<cr>", "Output" },

        ["<leader>tt"] = { "<cmd>lua require'neotest'.run.run()<cr>", "Test Nearest" },
        ["<leader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
        ["<leader>td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Test" },

        ["<leader>tj"] = { "<cmd>lua require('neotest').jump.next({ status = 'failed' })<cr>", "Failed Next" },
        ["<leader>tk"] = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<cr>", "Failed Previous" },

        -- ["<leader>ta"] = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Test" },
        -- ["<leader>ts"] = { "<cmd>lua require('neotest').run.stop()<cr>", "Test Stop" },
    }

    ---@diagnostic disable: missing-fields
    require("neotest").setup {
        adapters = {
            require "neotest-python" {
                dap = { justMyCode = false },
                runner = "pytest",
                python = "venv/bin/python",
            },
            require "neotest-go" {
                recursive_run = true,
            },
            require "neotest-vitest",
            require "neotest-zig",
            require "neotest-vim-test" {
                ignore_file_types = { "python", "go", "vim", "lua", "javascript", "typescript" },
            },
        },
    }
end

return M

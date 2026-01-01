local M = {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeTreeAdd"}
}

function M.config()
    require("which-key").register({
        prefix = "<leader>",
        h = {
            c = { "<cmd>ClaudeCode<cr>", "Open" },
            f = { "<cmd>ClaudeCodeFocus<cr>", "Focus" },
            r = { "<cmd>ClaudeCode --resume<cr>", "Resume Claude" },
            C = { "<cmd>ClaudeCode --continue<cr>", "Continue Claude" },
            b = { "<cmd>ClaudeCodeAdd %<cr><cmd>ClaudeCodeFocus<cr>", "Add current buffer" },
            v = { "<cmd>ClaudeCodeSend<cr>", "Send to visual selection", mode = { "v" } },
            t = { "<cmd>ClaudeCodeTreeAdd<cr>", "Add file", ft = { "neo-tree" } },
        },
    })

    require("claudecode").setup({
        terminal = {
            split_width_percentage = 0.3
        }
    })

end

return M

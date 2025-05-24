local M = {
    "eandrju/cellular-automaton.nvim",
    -- event = "VeryLazy"
    keys = { { "<leader>y" } },
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>ya"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it Rain!" },
        ["<leader>ys"] = { "<cmd>CellularAutomaton scramble<CR>", "Scrable" },
        ["<leader>yd"] = { "<cmd>CellularAutomaton game_of_life<CR>", "Trippy" },
    }
end

return M

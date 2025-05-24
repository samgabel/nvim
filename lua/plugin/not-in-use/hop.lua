local M = {
    "smoka7/hop.nvim",
    version = "*",
    -- keys = { { "<leader>h" } },
    event = "VeryLazy",
    opts = {},
}

function M.config()
    local hop = require "hop"
    local wk = require "which-key"
    wk.register {
        ["<leader>hs"] = { hop.hint_patterns, "Search", mode = { "n", "v" } },
        ["<leader>hw"] = { hop.hint_words, "Word", mode = { "n", "v" } },
        ["<leader>hl"] = { hop.hint_lines, "Line", mode = { "n", "v" } },
    }

    require("hop").setup {
        uppercase_labels = true,
    }
end

return M

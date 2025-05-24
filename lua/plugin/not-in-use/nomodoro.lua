local M = {
    "dbinagi/nomodoro",
    event = "VeryLazy",
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>na"] = { "<cmd>NomoWork<cr>", "Work" },
        ["<leader>ns"] = { "<cmd>NomoStop<cr>", "Stop" },
        ["<leader>nb"] = { "<cmd>NomoBreak<cr>", "Break" },
    }

    local icons = require "user.icons"

    require("nomodoro").setup {
        work_time = 25,
        break_time = 5,
        menu_available = true,
        texts = {
            on_break_complete = "TIME IS UP!",
            on_work_complete = "GOOD JOB!",
            status_icon = icons.misc.Time,
            timer_format = "!%0M:%0S", -- To include hours: '!%0H:%0M:%0S'
        },
        on_work_complete = function() end,
        on_break_complete = function() end,
    }
end

return M

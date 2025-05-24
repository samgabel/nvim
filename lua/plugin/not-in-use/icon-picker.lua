local M = {
    "ziontee113/icon-picker.nvim",
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>fi"] = { "<cmd>IconPickerNormal<cr>", "Icon" },
    }

    require("icon-picker").setup { disable_legacy_commands = true }
end

return M

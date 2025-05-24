local M = {
    "neogitorg/neogit",
    event = "VeryLazy",
    dependencies = {
        {
            "sindrets/diffview.nvim", -- optional - Diff integration
            event = "VeryLazy"
        },
        -- "ibhagwan/fzf-lua",        -- optional
    },
}

function M.config()
    local icons = require "user.icons"
    local wk = require "which-key"
    wk.register {
        ["<leader>gg"] = { "<cmd>Neogit<CR>", "Neogit" },
    }

    require("neogit").setup {
        auto_refresh = true,
        -- disable_builtin_notifications = false,
        use_magit_keybindings = false,
        -- Change the default way of opening neogit
        kind = "tab",
        -- Change the default way of opening popups
        popup = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            kind = "floating",
        },
        -- Change the default way of opening the commit popup
        commit_editor = {
            kind = "tab",
        },
        -- customize displayed signs
        signs = {
            -- { CLOSED, OPENED }
            section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
            item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
            hunk = { "", "" },
        },
        -- cutomize neogit plugins
        integrations = {
            -- diffview = true,
            telescope = false,
            fzf_lua = true,
        },
    }
end

return M

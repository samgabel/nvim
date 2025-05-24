local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
}

function M.config()

    -- modifies the time between a key press and the whichkey popup
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local mappings = {
        a = { "<cmd>Alpha<cr>", "Dashboard" },
        b = { "<cmd>NoiceDismiss<CR>", "Dismiss" },
        m = { "<cmd>Chmod<CR>", "Chmod Toggle" },
        q = { "<cmd>confirm q<CR>", "Quit" },
        w = { "<cmd>Wrap<CR>", "Wrap" },
        x = { "<cmd>DeleteListedBuffers<CR>", "Delete Buffers" },
        -- v = { "<cmd>vsplit | Alpha<CR>", "Split" },
        -- b = { name = "Buffers" }, --get rid of imbedded
        -- expandable --
        c = { name = " Compile" },
        f = { name = " Find" },
        g = {
            name = "󰊢 Git",
            x = { "<cmd>!ssh -O exit git@github.com<CR>", "Flush GitHub ControlMaster" },
        },
        k = {
            name = "󱃾 Kubectl",
            a = { "<cmd>!kubectl apply -f %<CR>", "Apply" },
            d = { "<cmd>!kubectl delete -f %<CR>", "Delete" },
        },
        l = { name = "󰣖 Lsp", mode = { "n", "v" } },
        o = {
            name = " Obsidian",
            l = { name = "Links" },
        },
        p = {
            name = "󰒺 Path",
            a = { ":lua PasteFilePathInline()<CR>", "Absolute" },
            r = { ":lua PasteRelativePathInline()<CR>", "Relative" },
        },
        s = { name = " Side" },
        t = { name = "󰙨 Test" },
        y = { name = "Fun" },
        z = { name = "󱂬 Zen" },
        d = { name = " Debug" },
        r = { name = " Repl", mode = { "n", "v" } },

        -- p = { name = "Plugins" },
    }

    local which_key = require "which-key"
    which_key.setup {
        icons = {
            -- gets rid of the "+" sign in front of the expandable options
            group = ""
        },
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = false,
                windows = false,
                nav = false,
                z = false,
                g = false,
            },
        },
        window = {
            border = "rounded",
            position = "bottom",
            padding = { 2, 2, 2, 2 },
        },
        ignore_missing = true,
        show_help = false,
        show_keys = false,
        disable = {
            buftypes = {},
            filetypes = { "TelescopePrompt" },
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
    }

    which_key.register(mappings, opts)
end

return M

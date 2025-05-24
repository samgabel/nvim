local M = {
    "hedyhli/outline.nvim",
    -- cmd = { "Outline", "OutlineOpen" },
    event = "VeryLazy"
}


function M.config()

    require("which-key").register({
        ["<leader>so"] = { "<CMD>Outline<CR>", "Outline" }
    })

    require("outline").setup({
        outline_window = {
            position = "left",
            jump_highlight_duration = 100,
            auto_jump = true
        },
        outline_items = {
            -- show_symbol_details = false,
            -- show_symbol_lineno = true
        },
        symbols = {
            icon_fetcher = function(icon) return require("user.icons").kind[icon] end
        },
        keymaps = {
            peek_location = {},
            toggle_preview = "o",
            goto_location = {},
            goto_and_close = "<CR>",
            fold_toggle = "f",
            fold_all = "z",
            unfold_all = "Z",
            hover_symbol = "<S-k>"
        }
    })

end


return M

local lang_utils = require("user.lang-utils")

return {



-- ========================================================================================
-- TREESITTER -> LANGUAGE PARSER
-- ========================================================================================
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        config = function()
            -- Treesitter
            require("nvim-treesitter").install(lang_utils.treesitters)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = lang_utils.treesitters,
                callback = function() vim.treesitter.start() end,
            })
            -- Treesitter Context
            require('treesitter-context').setup({
                 enable = true,
                 mode = "topline",
             })
            vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })
            vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true, sp = "Grey" })
        end
    },



-- ========================================================================================
-- TREESITTER TEXTOBJECTS-> SYNTAX-AWARE TEXT OBJECTS
-- see /lua/queries
-- ========================================================================================
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = true,
        init = function()
            -- Disable built-in ftplugin mappings to avoid conflicts
            vim.g.no_plugin_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'V',
                    },
                    include_surrounding_whitespace = false,
                },
                move = {
                    set_jumps = true,
                },
                lsp_interop = {
                    enable = true,
                    border = 'rounded',
                    floating_preview_opts = {},
                },
            })
            -- Keymaps for select
            local ntts = require("nvim-treesitter-textobjects.select")
            vim.keymap.set({ "x", "o" }, "ia", function() ntts.select_textobject("@parameter.inner", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "aa", function() ntts.select_textobject("@parameter.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ic", function() ntts.select_textobject("@call.inner", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ac", function() ntts.select_textobject("@call.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "if", function() ntts.select_textobject("@function.inner", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "af", function() ntts.select_textobject("@function.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "it", function() ntts.select_textobject("@type.inner", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "at", function() ntts.select_textobject("@type.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ii", function() ntts.select_textobject("@conditional.consequence", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ai", function() ntts.select_textobject("@conditional.condition", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "il", function() ntts.select_textobject("@loop.body", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "al", function() ntts.select_textobject("@loop.condition", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ir", function() ntts.select_textobject("@method.receiver.inner", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ar", function() ntts.select_textobject("@method.receiver.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "ao", function() ntts.select_textobject("@operator.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "<C-h>o", function() ntts.select_textobject("@operator.lhs", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "<C-l>o", function() ntts.select_textobject("@operator.rhs", "textobjects") end)
            -- Keymaps for move
            local nttm = require("nvim-treesitter-textobjects.move")
            vim.keymap.set({ "n", "x", "o" }, "]a", function() nttm.goto_next_start("@parameter.inner", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]c", function() nttm.goto_next_start("@call.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]f", function() nttm.goto_next_start("@function.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]i", function() nttm.goto_next_start("@conditional.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]l", function() nttm.goto_next_start("@loop.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]o", function() nttm.goto_next_start("@operator.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]t", function() nttm.goto_next_start("@type.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]A", function() nttm.goto_next_end("@parameter.inner", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]C", function() nttm.goto_next_end("@call.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]F", function() nttm.goto_next_end("@function.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]I", function() nttm.goto_next_end("@conditional.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]L", function() nttm.goto_next_end("@loop.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]O", function() nttm.goto_next_end("@operator.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "]T", function() nttm.goto_next_end("@type.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[a", function() nttm.goto_previous_start("@parameter.inner", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[c", function() nttm.goto_previous_start("@call.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[f", function() nttm.goto_previous_start("@function.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[i", function() nttm.goto_previous_start("@conditional.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[l", function() nttm.goto_previous_start("@loop.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[o", function() nttm.goto_previous_start("@operator.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[t", function() nttm.goto_previous_start("@type.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[A", function() nttm.goto_previous_end("@parameter.inner", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[C", function() nttm.goto_previous_end("@call.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[F", function() nttm.goto_previous_end("@function.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[I", function() nttm.goto_previous_end("@conditional.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[L", function() nttm.goto_previous_end("@loop.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[O", function() nttm.goto_previous_end("@operator.outer", "textobjects") end)
            vim.keymap.set({ "n", "x", "o" }, "[T", function() nttm.goto_previous_end("@type.outer", "textobjects") end)
            -- Repeatable move
            local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end
    }



}

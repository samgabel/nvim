local M = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
}

function M.config()

    local text_objects = {
        a = { "argument/param" },
        c = { "function [c]all" },
        f = { "[f]unction declaration" },
        i = { "[if/else" },
        l = { "loop" },
        o = { "operator" },
        r = { "method [r]eceiver" },
        t = { "type" },
    }

    require("which-key").register({
        ["v"] = {
            name = "[V]isual TS-TextObjects",
            i = vim.tbl_extend("force", { name = "inside" }, text_objects),
            a = vim.tbl_extend("force", { name = "around" }, text_objects),
            ["<C-h>"] = {
                name = "left",
                o = { "operator" },
            },
            ["<C-l>"] = {
                name = "right",
                o = { "operator" },
            },
        },
        ["c"] = {
            name = "[C]hange TS-TextObjects",
            i = vim.tbl_extend("force", { name = "inside" }, text_objects),
            a = vim.tbl_extend("force", { name = "around" }, text_objects),
            ["<C-h>"] = {
                name = "left",
                o = { "operator" },
            },
            ["<C-l>"] = {
                name = "right",
                o = { "operator" },
            },
        },
        ["d"] = {
            name = "[D]elete TS-TextObjects",
            i = vim.tbl_extend("force", { name = "inside" }, text_objects),
            a = vim.tbl_extend("force", { name = "around" }, text_objects),
            ["<C-h>"] = {
                name = "left",
                o = { "operator" },
            },
            ["<C-l>"] = {
                name = "right",
                o = { "operator" },
            },
        },
        -- ["keybinding"] = { "LSP peek code" },
    })


    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
        textobjects = {
            select = {
                enable = true,
                -- automatically jump forward to textobj, similar to target.vim
                lookahead = true,

                keymaps = {
                    -- you can use the capture groups defined in textobjects.scm
                    ["ia"] = "@parameter.inner",
                    ["aa"] = "@parameter.outer",

                    ["ic"] = "@call.inner",
                    ["ac"] = "@call.outer",

                    ["if"] = "@function.inner",
                    ["af"] = "@function.outer",

                    ["it"] = "@type.inner",
                    ["at"] = "@type.outer",

                    ["ii"] = "@conditional.consequence",
                    ["ai"] = "@conditional.condition",

                    ["il"] = "@loop.body",
                    ["al"] = "@loop.condition",

                    ["ir"] = "@method.receiver.inner",
                    ["ar"] = "@method.receiver.outer",

                    ["ao"] = "@operator.outer",
                    ["<C-h>o"] = "@operator.lhs",
                    ["<C-l>o"] = "@operator.rhs",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
                    ["]c"] = { query = "@call.outer", desc = "Next function call start" },
                    ["]f"] = { query = "@function.outer", desc = "Next method receiver" },
                    ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                    ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                    ["]o"] = { query = "@operator.outer", desc = "Next operator start" },
                    ["]t"] = { query = "@type.outer", desc = "Next type start" },
                },
                goto_next_end = {
                    ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
                    ["]C"] = { query = "@call.outer", desc = "Next function call end" },
                    ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
                    ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                    ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    ["]O"] = { query = "@operator.outer", desc = "Next operator end" },
                    ["]T"] = { query = "@type.outer", desc = "Next type end" },
                },
                goto_previous_start = {
                    ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
                    ["[c"] = { query = "@call.outer", desc = "Previous function call start" },
                    ["[f"] = { query = "@function.outer", desc = "Previous method/function def start" },
                    ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
                    ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
                    ["[o"] = { query = "@operator.outer", desc = "Previous operator start" },
                    ["[t"] = { query = "@type.outer", desc = "Previous type start" },
                },
                goto_previous_end = {
                    ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
                    ["[C"] = { query = "@call.outer", desc = "Previous function call end" },
                    ["[F"] = { query = "@function.outer", desc = "Previous method/function def end" },
                    ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
                    ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
                    ["[O"] = { query = "@operator.outer", desc = "Previous operator end" },
                    ["[T"] = { query = "@type.outer", desc = "Previous type end" },
                },
            },
            lsp_interop = {
                enable = true,
                border = 'rounded',
                floating_preview_opts = {},
                -- peek_definition_code = {
                --     ["<keybinding>"] = "@function.outer",
                -- },

            }
        },
    })

    -- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    --
    -- -- ensure ; goes forward and , goes backward regardless of the last direction
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    --
    -- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    -- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    -- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

    -- Sets the ~/.config/nvim/queries/ dir in the runtimepath
    vim.opt.runtimepath:append(vim.fn.stdpath('config')..'/queries')

end

return M

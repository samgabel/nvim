return {



-- ========================================================================================
-- WHICH-KEY -> KEYBINDS
-- ========================================================================================
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({
                delay = 300,
                sort = { "group", "manual" },
                preset = "helix",
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
                        motions = false,
                        text_objects = false,
                        operators = false,
                        windows = false,
                        nav = false,
                        z = true,
                        g = true,
                    },
                },
                win = {
                    title = true,
                },
                show_help = true,
                show_keys = true,
                disable = {
                    bt = {},
                    ft = {
                        "snacks_picker_input",
                        "snacks_picker_list",
                        "snacks_terminal",
                    },
                },
            })
            -- User Leader Keymaps
            wk.add(require("user.keymaps").keymaps)
        end
    },



-- ========================================================================================
-- NEO-TREE -> FILESYSTEM
-- ========================================================================================
    {
        -- DIRECOTRY TREE
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            -- NOTE: add this for changing file and cleanup
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#handle-rename-or-move-file-event
        },
        config = function()
            require("neo-tree").setup({
                window = {
                    mappings = {
                        ["o"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                        ["O"] = "focus_preview",
                        ["s"] = "none",
                        ["S"] = "none",
                        -- TODO: figure out why this isn't working
                        ["<c-x>"] = "open_split",
                        ["<c-v>"] = "open_vsplit",
                        ["f"] = "open",
                    },
                },
                filesystem = {
                    highjack_netrw_behavior = "open_current", -- see in autocmds for highjacking function
                    filtered_items = {
                        -- manually hide certain files/directories
                        hide_by_name = {
                            "venv",
                            "__pycache__",
                            "pyproject.toml",
                        },
                    },
                    window = {
                        position = "current",
                        mappings = {
                            ["f"] = "open",
                            ["h"] = "navigate_up",
                            ["l"] = "set_root",
                            ["Z"] = "expand_all_nodes",
                            -- remove default keymaps
                            ["."] = "none",
                            ["<"] = "none",
                            [">"] = "none",
                            ["<bs>"] = "none",
                            ["<space>"] = "none",
                            ["A"] = "none",
                            ["C"] = "none",
                            ["P"] = "none",
                            -- ["f"] = "none",
                            -- ["e"] = "none",
                            ["t"] = "none",
                            ["w"] = "none",
                            ["[g"] = "none",
                            ["]g"] = "none",
                            ["oc"] = "none",
                            ["od"] = "none",
                            ["og"] = "none",
                            ["om"] = "none",
                            ["on"] = "none",
                            ["os"] = "none",
                            ["ot"] = "none",
                        },
                        fuzzy_finder_mappings = { -- sets selection navigation for search
                            ["<C-j>"] = "move_cursor_down",
                            ["<C-k>"] = "move_cursor_up",
                        },
                    },
                    -- components = {
                    --     harpoon_index = function(config, node, _)
                    --         local Marked = require("harpoon.mark")
                    --         local path = node:get_id()
                    --         local success, index = pcall(Marked.get_index_of, path)
                    --         if success and index and index > 0 then
                    --             return {
                    --                 text = string.format("  %d", index), -- <-- Add your favorite harpoon like arrow here
                    --                 highlight = config.highlight or "NeoTreeDirectoryIcon",
                    --             }
                    --         else
                    --             return {
                    --                 text = " "
                    --             }
                    --         end
                    --     end,
                    -- },
                    renderers = {
                        file = {
                            { "indent" },
                            -- { "harpoon_index" }, --> This is what actually adds the harpoon component in where you want it
                            { "icon" },
                            {
                                "container",
                                content = {
                                    {
                                        "name",
                                        zindex = 10,
                                    },
                                    {
                                        "symlink_target",
                                        zindex = 10,
                                        highlight = "NeoTreeSymbolicLinkTarget",
                                    },
                                    { "clipboard", zindex = 10 },
                                    { "bufnr", zindex = 10 },
                                    { "modified", zindex = 20, align = "right" },
                                    { "diagnostics", zindex = 20, align = "right" },
                                    { "git_status", zindex = 10, align = "right" },
                                    { "file_size", zindex = 10, align = "right" },
                                    { "type", zindex = 10, align = "right" },
                                    { "last_modified", zindex = 10, align = "right" },
                                    { "created", zindex = 10, align = "right" },
                                },
                            },
                        },
                    },
                },
            })
        end
    },



-- ========================================================================================
-- GITSIGNS -> GIT Utility
-- ========================================================================================
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            local icons = require("user.icons")
            require("gitsigns").setup({
                signs = {
                    add = { hl = "GitSignsAdd", text = icons.ui.BoldLineMiddle, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                    change = { hl = "GitSignsChange", text = icons.ui.BoldLineMiddle, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                    delete = { hl = "GitSignsDelete", text = icons.ui.TriangleShortArrowRight, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    topdelete = { hl = "GitSignsDelete", text = icons.ui.TriangleShortArrowRight, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    changedelete = { hl = "GitSignsChange", text = icons.ui.BoldLineDashedMiddle, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" }
                },
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                update_debounce = 200,
                max_file_length = 40000,
                preview_config = {
                    border = "rounded",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
            })
        end
    },



-- ========================================================================================
-- TROUBLE -> BETTER DIAGNOSTICS
-- ========================================================================================
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("trouble").setup({
                auto_close = true,
                multiline = false,
                use_diagnostic_signs = true
                -- TODO: figure out how to get telescope to send loclist and quickfix to trouble with (selected)<C-q> (all)<M-q>
            })
        end
    },



-- ========================================================================================
-- BREADCRUMBS -> EDITOR BREADCRUMBS
-- ========================================================================================
    {
        {
            name = "breadcrumbs",
            dir = vim.fn.stdpath("config") .. "/lua/user/breadcrumbs",
            event = "BufEnter",
            dependencies = "SmiteshP/nvim-navic",
            config = function()
                require("user.breadcrumbs").setup()
            end
        },
        {
            "SmiteshP/nvim-navic",
            lazy = true,
            config = function()
                local icons = require "user.icons"
                require("nvim-navic").setup({
                    icons = icons.kind,
                    highlight = true,
                    lsp = {
                        auto_attach = true,
                    },
                    click = true,
                    separator = " " .. icons.ui.DoubleChevronRight .. " ",
                    depth_limit = 0,
                    depth_limit_indicator = "..",
                })
            end
        },
    },



-- ========================================================================================
-- ILLUMINATE -> TREESITTER/LSP SYMBOL HIGHLIGHT
-- ========================================================================================
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require("illuminate").configure {
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
                filetypes_denylist = {
                    "dapui_breakpoints",
                    "dapui_scopes",
                    "dapui_stacks",
                    "dapui_watches",
                    "DiffviewFiles",
                    "harpoon",
                    "lazy",
                    "mason",
                    "neo-tree",
                    "Outline",
                    "Trouble",
                },
            }
        end
    },



-- ========================================================================================
-- RAINBOW-DELIMITERS -> COLOR CODED DELIMITERS
-- ========================================================================================
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "VeryLazy",
        config = function()
            require("rainbow-delimiters.setup").setup()
        end
    },



-- ========================================================================================
-- OUTLINE -> DOCUMENT SYMBOL OUTLINE
-- ========================================================================================
    {
        "hedyhli/outline.nvim",
        cmd = { "Outline", "OutlineOpen" },
        config = function()
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
    },



}

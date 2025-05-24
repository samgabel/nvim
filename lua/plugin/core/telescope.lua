local M = {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
        { "nvim-telescope/telescope-ui-select.nvim", lazy = true },
        { "ANGkeith/telescope-terraform-doc.nvim", lazy = true },
        { "debugloop/telescope-undo.nvim", lazy = true },
        { "crispgm/telescope-heading.nvim", lazy = true },
    },
}

function M.config()
    local wk = require "which-key"
    wk.register {
        -- layout_config={width=0.94} seems to be the sweet spot for this current window size of iTerm(162 x 42) -> for side_by_side view
        ["<leader>ff"] = { "<cmd>Telescope find_files layout_config={width=100}<cr>", "Quick Files" },
        ["<leader>fF"] = { "<cmd>Telescope fd find_command=rg,--no-ignore,--files hidden=true layout_config={width=0.94}<cr>", "Preview Files" },
        ["<leader>fs"] = { "<cmd>Telescope live_grep layout_config={width=100}<cr>", "Text" },
        ["<leader>fc"] = { "<cmd>Telescope todo-comments initial_mode=normal layout_config={width=100}<cr>", "Todo" },
        ["<leader><leader>"] = { "<cmd>Telescope buffers layout_config={width=100}<cr>", "Buffers" },
        -- ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
        -- ["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        ["<leader>fo"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols layout_config={width=0.94}<cr>", "Outline Symbols" },
        ["<leader>fh"] = { "<cmd>Telescope help_tags layout_config={width=0.94}<cr>", "Help" },
        ["<leader>fe"] = { "<cmd>Telescope notify initial_mode=normal layout_config={width=0.94}<cr>", "Errors" },
        ["<leader>fl"] = { "<cmd>Telescope resume initial_mode=normal<cr>", "Last Search" },
        -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        ["<leader>fu"] = { "<cmd>Telescope undo initial_mode=normal layout_config={width=0.94} entry_format='$TIME'<cr>", "Undo Tree" },
        ["<leader>ft"] = { "<cmd>Telescope terraform_doc<cr>", "Terraform Doc" },
        ["<leader>fm"] = { "<cmd>Telescope heading initial_mode=insert layout_config={width=0.94}<cr>", "Markdown Heading" },
    }

    local icons = require("user.icons")
    local actions = require("telescope.actions")
    local trouble = require("trouble.providers.telescope")

    -- SETUP --
    require("telescope").setup {
        defaults = {
            prompt_prefix = icons.ui.Telescope .. " ",
            selection_caret = icons.ui.Forward .. " ",
            entry_prefix = "   ",
            initial_mode = "insert",
            selection_strategy = "reset",
            path_display = { "smart" },
            color_devicons = true,
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob=!.git/",
            },
            -- Ignore certain directories in telescope search
            file_ignore_patterns = {
                ".git/",
                "venv/",
                "__pycache__/",
            },

            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,

                    ["<C-t>"] = trouble.open_with_trouble,
                },
                n = {
                    ["f"] = actions.select_default,

                    ["q"] = actions.close,
                    ["<esc>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,

                    ["<C-t>"] = trouble.open_with_trouble,

                },
            },
        },
        pickers = {
            live_grep = {
                theme = "dropdown",
            },

            grep_string = {
                theme = "dropdown",
            },

            find_files = {
                theme = "dropdown",
                previewer = false,
            },

            buffers = {
                theme = "dropdown",
                previewer = true,
                initial_mode = "normal",
                mappings = {
                    i = {
                        ["<C-d>"] = actions.delete_buffer,
                    },
                    n = {
                        ["dd"] = actions.delete_buffer,
                    },
                },
            },

            planets = {
                show_pluto = true,
                show_moon = true,
            },

            colorscheme = {
                enable_preview = true,
            },

            lsp_references = {
                theme = "dropdown",
                initial_mode = "normal",
            },

            lsp_definitions = {
                theme = "dropdown",
                initial_mode = "normal",
            },

            lsp_declarations = {
                theme = "dropdown",
                initial_mode = "normal",
            },

            lsp_implementations = {
                theme = "dropdown",
                initial_mode = "normal",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown()
            },
            heading = {
                treesitter = true
            },
        },
    }

    -- EXTENSION LOADING --
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("terraform_doc")
    require("telescope").load_extension("undo")
    require("telescope").load_extension("notify")
    require("telescope").load_extension("heading")

end

return M

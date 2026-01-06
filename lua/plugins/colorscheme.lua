return {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 10000, -- make sure to load this before all the other start plugins
    config = function()
        require("catppuccin").setup {
            integrations = {
                alpha = true,
                neotree = true,
                noice = true,
                notify = true,
                cmp = true,
                harpoon = true,
                which_key = true,
                mason = true,
                navic = true,
                neotest = true,
                dap = true,
                aerial = true,
                dashboard = true,
                flash = true,
                fzf = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mini = true,
                snacks = true,
                telescope = true,
                treesitter_context = true,
            },
            transparent_background = true,
            float = {
                transparent = true,
                solid = false
            }
        }
        vim.cmd.colorscheme "catppuccin"
    end
}

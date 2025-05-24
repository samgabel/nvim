local M = {
    "catppuccin/nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()

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
            -- hop = true,
            -- lsp_trouble = true,
        },
        transparent_background = true,
    }

    vim.cmd.colorscheme "catppuccin"

end

return M

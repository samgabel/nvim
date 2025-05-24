local M = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000
}

function M.config()

    -- Needs work: https://github.com/folke/tokyonight.nvim
        -- md files do not have italic or bold coloring, also weird highlight for inline code

    require("tokyonight").setup({
        style = "moon",
        transparent = true,
        terminal_colors = true,
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark", -- style for sidebars, see below
            floats = "dark", -- style for floating windows
        },
    })

    vim.cmd.colorscheme("tokyonight-moon")

end



return M

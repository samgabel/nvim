local M = {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
}


function M.config()
    require("trouble").setup({
        auto_close = true,
        multiline = false,
        use_diagnostic_signs = true
        -- TODO: figure out how to get telescope to send loclist and quickfix to trouble with (selected)<C-q> (all)<M-q>
    })
end


return M

local N = {
    "SmiteshP/nvim-navic",
}

function N.config()
    local icons = require "user.icons"
    require("nvim-navic").setup {
        icons = icons.kind,
        highlight = true,
        lsp = {
            auto_attach = true,
        },
        click = true,
        separator = " " .. icons.ui.DoubleChevronRight .. " ",
        depth_limit = 0,
        depth_limit_indicator = "..",
    }
end

return N

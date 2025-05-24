local M = {
    "nvim-tree/nvim-web-devicons",
    lazy = true
}

function M.config()
    require("nvim-web-devicons").setup({
        override_by_filename = {
            ["go"] = {
                icon = "",
                color = "#519aba",
                name = "go"
            },
            ["makefile"] = {
                icon = "",
                color = "#d97706",
                name = "make"
            },
            ["mod"] = {
                icon = "",
                color = "#FF0090",
                name = "gomod"
            },
            ["sum"] = {
                icon = "",
                color = "#FF0090",
                name = "gosum"
            },
            ["asm"] = {
                icon = "",
                color = "#5f43e9",
                name = "asm"
            },
        }
    })
end

return M

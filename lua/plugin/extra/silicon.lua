local M = {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
}


function M.config()
    require("silicon").setup({
        font = "Liga SFMono Nerd Font=34",
        theme = "Visual Studio Dark+",
        -- background_image = "~/Downloads/wallpapers/TheBeach/sunrise.png",
        no_line_number = true,
        to_clipboard = true,
    })
end


return M

local M = {
    "folke/flash.nvim",
    event = "VeryLazy"
}


function M.config()

    require("flash").setup({
        -- search = {
        --     exclude = {
        --         "illuminate"
        --     }
        -- },
        jump = {
            jumplist = false
        },
        modes = {
            search = {
                enabled = false
            },
            char = {
                highlight = { backdrop = false },
                char_actions = function(motion)
                    return {
                        [";"] = "right", -- set to `right` to always go right
                        [","] = "left",  -- set to `left` to always go left
                        -- clever-f style
                        [motion:lower()] = "next",
                        [motion:upper()] = "prev",
                        -- jump2d style: same case ("f") goes next, opposite case ("F") goes prev
                        [motion] = "next",
                        [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
                    }
                end,
            },
        }
    })

end


return M

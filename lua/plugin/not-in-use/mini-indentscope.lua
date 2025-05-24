local M = {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufEnter",
}


function M.config()

    require('mini.indentscope').setup({
        mappings = {
            goto_top = '[a',
            goto_bottom = ']a',
        },
        options = {
            try_as_border = true,
        },
        -- symbol = '|',
    })

end

return M

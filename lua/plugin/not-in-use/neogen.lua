local M = {
    "danymat/neogen",
    version = "*",
    lazy = true
}


function M.config()

    require("which-key").register({
        ["<leader>ld"] = { "<CMD>Neogen<CR>", "Generate Doc" }
    })

    require("neogen").setup({
        snippet_engine = "luasnip"
    })
end


return M

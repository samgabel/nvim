local M = {
    "jellydn/quick-code-runner.nvim",
    ft = { "python", "javascript", "go", "c" },
    dependencies = {
        "MunifTanjim/nui.nvim"
    },
}


function M.config()

    require("which-key").register({
        ["<leader>rr"] = { "ggVG<ESC>:%QuickCodeRunner<CR>:setlocal wrap<CR>", "Run file" },
        ["<leader>rl"] = { "V:QuickCodeRunner<CR>:setlocal wrap<CR>", "Run line" },
        ["<leader>rs"] = { ":QuickCodeRunner<CR>:setlocal wrap<CR>", "Run selection", mode = { "v" } },
        ["<leader>re"] = { "<CMD>QuickCodePad<CR>", "View pad", mode = { "n" } },
        ["<leader>rp"] = { "y:QuickCodePad<CR>ggVGP", "Paste to pad", mode = { "v" } },
        ["<leader>ra"] = { "y:QuickCodePad<CR>Go<ESC>p", "Append to pad", mode = { "v" } },
    })

    require("quick-code-runner").setup({
        debug = false,
        file_types = {
            javascript = { "node" },    -- Run command for javascript, you can change to `bun` or `deno`
            typescript = { "bun run" }, -- Run command for typescript, you can change to `npx tsx run` or `deno`
            python = { "python3 -u" },  -- Run command for python
            go = { "go run" }
        }
    })

end


return M

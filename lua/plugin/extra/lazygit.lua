local M = {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
}


function M.config()

    require("which-key").register({
        ["<leader>gg"] = { "<cmd>LazyGit<CR>", "LazyGit" },
    })

    -- vim.g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
    -- vim.g.lazygit_config_file_path = os.getenv("HOME") .. "/.config/lazygit/config.yml"  -- custom config file path

end


return M

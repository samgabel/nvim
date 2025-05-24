local M = {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
}

function M.config()

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<s-m>", "<cmd>lua require('plugin.extra.harpoon').mark_file()<cr>", opts)
    keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)

    keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
    keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
    keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts)
    keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts)


    require("harpoon").setup({
        global_settings = {
            excluded_filetypes = { "neo-tree" },
        }
    })

end

function M.mark_file()
    require("harpoon.mark").add_file()
    vim.notify "  Marked File"
end

return M

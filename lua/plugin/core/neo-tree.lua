local M = {
    -- DIRECOTRY TREE
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information

        -- TODO: add this for changing file and cleanup
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#handle-rename-or-move-file-event
    },
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>e"] = { "<CMD>Neotree focus current reveal_force_cwd<CR>", "Filesystem" }, -- toggle neotree directories
        ["<leader>se"] = { "<CMD>Neotree toggle left<CR>", "Filesystem" }, -- toggle neotree directories
        ["<leader>sg"] = { "<CMD>Neotree toggle git_status<CR>", "Git Status" }, -- toggle neotree git
        ["<leader>sb"] = { "<CMD>Neotree toggle buffers<CR>", "Buffers" }, -- toggle neotree buffers
    }

    require("neo-tree").setup {

        window = {
            mappings = {
                ["o"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["O"] = "focus_preview",
                ["s"] = "none",
                ["S"] = "none",
                ["<c-x>"] = "open_split",
                ["<c-v>"] = "open_vsplit",
                ["f"] = "open",
            },
        },

        filesystem = {
            highjack_netrw_behavior = "open_current", -- see in autocmds for highjacking function
            filtered_items = {
                -- manually hide certain files/directories
                hide_by_name = {
                    "venv",
                    "__pycache__",
                    "pyproject.toml"
                },
            },
            window = {
                position = "current",
                mappings = {
                    ["f"] = "open",
                    ["h"] = "navigate_up",
                    ["l"] = "set_root",
                    ["Z"] = "expand_all_nodes",

                    -- remove default keymaps
                    ["."] = "none",
                    ["<"] = "none",
                    [">"] = "none",
                    ["<bs>"] = "none",
                    ["<space>"] = "none",
                    ["A"] = "none",
                    ["C"] = "none",
                    ["P"] = "none",
                    -- ["f"] = "none",
                    -- ["e"] = "none",
                    ["t"] = "none",
                    ["w"] = "none",
                    ["[g"] = "none",
                    ["]g"] = "none",
                    ["oc"] = "none",
                    ["od"] = "none",
                    ["og"] = "none",
                    ["om"] = "none",
                    ["on"] = "none",
                    ["os"] = "none",
                    ["ot"] = "none",
                },
                fuzzy_finder_mappings = { -- sets selection navigation for search
                    ["<C-j>"] = "move_cursor_down",
                    ["<C-k>"] = "move_cursor_up",
                },
            },
            components = {
                harpoon_index = function(config, node, _)
                    local Marked = require("harpoon.mark")
                    local path = node:get_id()
                    local success, index = pcall(Marked.get_index_of, path)
                    if success and index and index > 0 then
                        return {
                            text = string.format("  %d", index), -- <-- Add your favorite harpoon like arrow here
                            highlight = config.highlight or "NeoTreeDirectoryIcon",
                        }
                    else
                        return {
                            text = " "
                        }
                    end
                end,
            },
            renderers = {
                file = {
                    { "indent" },
                    { "harpoon_index" }, --> This is what actually adds the harpoon component in where you want it
                    { "icon" },
                    {
                        "container",
                        content = {
                            {
                                "name",
                                zindex = 10
                            },
                            {
                                "symlink_target",
                                zindex = 10,
                                highlight = "NeoTreeSymbolicLinkTarget",
                            },
                            { "clipboard", zindex = 10 },
                            { "bufnr", zindex = 10 },
                            { "modified", zindex = 20, align = "right" },
                            { "diagnostics",  zindex = 20, align = "right" },
                            { "git_status", zindex = 10, align = "right" },
                            { "file_size", zindex = 10, align = "right" },
                            { "type", zindex = 10, align = "right" },
                            { "last_modified", zindex = 10, align = "right" },
                            { "created", zindex = 10, align = "right" },
                        },
                    },
                },
            },
        },

    }
end

--  event = 'after_render',
--  handler = function ()
--    local state = require('neo-tree.sources.manager').get_state('filesystem')
--    if not require('neo-tree.sources.common.preview').is_active() then
--      state.config = { use_float = false } -- or whatever your config is
--      state.commands.toggle_preview(state)
--    end
--  end

return M





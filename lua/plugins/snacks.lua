-- ========================================================================================
-- SNACKS -> UTILITY PLUGINS
-- ========================================================================================

local M = {
    "folke/snacks.nvim",
    lazy = false,
}

function M.config()
    require("snacks").setup({
        -- statuscolumn = {
        --     enabled = true
        -- },

        notifier = {
            enabled = true,
            timeout = 5000,
            level = vim.log.levels.TRACE,
            top_down = false,
        },

        input = {
            enabled = true
        },

        indent = {
            enabled = true
        },

        gitbrowse = {
            enabled = true,
            remote_patterns = {
                { "^git@github-.*:(.+)%.git$", "https://github.com/%1" },
            }
        },

        lazygit = {
            enabled = true,
        },

        terminal = {
            enabled = true,
        },

        toggle = {
            enabled = true,
        },

        gh = {
            enabled = true,
        },

        picker = {
            enabled = true,
            sources = {
                gh_issue = {},
                gh_pr = {}
            }
        },

        dashboard = {
            enabled = true,
            preset = {
                pick = nil,
                header = [[
                ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                
                ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                
                ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                
                ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                
                ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                
                ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                
                ]],
                keys = {
                    { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
                    { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "s", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "e", desc = "Filesystem",      action = ":Neotree current" },
                    { icon = " ", key = "g", desc = "Git",             action = ":lua Snacks.lazygit()" },
                    { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = "󰒲 ", key = "l", desc = "Lazy",            action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
                },
            },
        },
    })
end

return M

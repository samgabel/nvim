return {



-- ========================================================================================
-- OPENCODE -> AI CODING AGENT
-- plugin for nvim interface with Opencode
-- ========================================================================================
    {
        "NickvanDyke/opencode.nvim",
        dependencies = { "folke/snacks.nvim" },
        event = "VeryLazy",
        config = function()
            local tmux = require("user.opencode.tmux-provider")
            -- `server.stop`/`server.toggle` were removed upstream (commit a7c4dd7);
            -- only `port` and `start` are honored now. Toggle is handled in user-land
            -- via the tmux provider (see keymaps `<leader>ht`).
            require("opencode.config").opts.server = {
                port = tmux.port,
                start = tmux.start,
            }
        end
    }



}

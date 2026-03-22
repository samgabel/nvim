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
            require("opencode.config").opts.server = {
                port = tmux.port,
                start = tmux.start,
                stop = tmux.stop,
                toggle = tmux.toggle,
            }
        end
    }



}

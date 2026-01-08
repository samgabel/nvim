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
            -- custom logic for proper tmux sourcing of env vars w/ mise
            local Tmux = require("opencode.provider.tmux")
            function Tmux:start()
                local pane_id = self:get_pane_id()
                if not pane_id then
                    local pwd = vim.fn.getcwd()
                    self.pane_id = vim.fn.system(string.format(
                        "tmux split-window -d -P -F '#{pane_id}' %s 'cd \"%s\" && eval \"$(mise activate zsh)\" && %s'",
                        self.opts.options,
                        pwd,
                        self.cmd:gsub('"', '\\"')
                    ))
                    -- vim.fn.system("tmux select-pane -t " .. self.pane_id)
                end
            end
            -- options
            vim.g.opencode_opts = {
                provider = {
                    enabled = "tmux",
                    tmux = {
                        options = "-h -l 41%"
                    }
                }
            }
        end
    }



}

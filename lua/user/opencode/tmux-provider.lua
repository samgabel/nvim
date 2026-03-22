local M = {}

local pane_id = nil
local tmux_opts = "-h -l 41%"

-- grab a free port from the OS (unique per nvim instance)
---@diagnostic disable: undefined-field
local srv = vim.uv.new_tcp()
srv:bind("127.0.0.1", 0)
M.port = srv:getsockname().port
srv:close()

local opencode_cmd = "opencode --port " .. M.port

local function get_pane_id()
    if pane_id then
        if vim.fn.system("tmux list-panes -t " .. pane_id):match("can't find pane") then
            pane_id = nil
        end
    end
    return pane_id
end

function M.start()
    if get_pane_id() then return end
    local pwd = vim.fn.getcwd()
    pane_id = vim.trim(vim.fn.system(string.format(
        "tmux split-window -d -P -F '#{pane_id}' %s 'cd \"%s\" && eval \"$(mise activate zsh)\" && %s'",
        tmux_opts,
        pwd,
        opencode_cmd
    )))
    if pane_id and pane_id ~= "" then
        vim.fn.system(string.format("tmux set-option -t %s -p allow-passthrough off", pane_id))
    end
end

function M.stop()
    if pane_id then
        os.execute("tmux kill-pane -t " .. pane_id .. " 2>/dev/null")
        pane_id = nil
    end
end

function M.toggle()
    if get_pane_id() then
        M.stop()
    else
        M.start()
    end
end

-- clean up tmux pane on nvim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function() pcall(M.stop) end,
})

return M

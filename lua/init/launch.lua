LAZY_PLUGIN_SPEC = {}

function spec(item)
    table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- Compatability with TMUX (status bar state management)
local function manage_tmux_status()
    if not os.getenv("TMUX") then
        return
    end

    vim.api.nvim_command [[autocmd VimEnter * silent !tmux set status off]]

    if os.getenv("TMUX_TMP_POPUP") then
        return
    end

    vim.api.nvim_command [[autocmd VimLeave * silent !tmux set status on]]
end
manage_tmux_status()

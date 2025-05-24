local M = {
    "nvim-lualine/lualine.nvim",
    -- lazy = false,
    event = { "BufRead", "BufNewFile", "StdinReadPre" },
    dependencies = {
        "linrongbin16/lsp-progress.nvim",
    },
}


if os.getenv("TMUX") then
    -- Initial update of tmux session info
    UpdateTmuxSessionInfo()
    -- UpdateTmuxSessionInfo() when <C-s> is pressed (in terminal <C-s> will freeze until <C-q)
    -- in tmux.conf the "z" keybind will also send <C-s> to vim in additon to toggling zoom
    vim.api.nvim_set_keymap('', '<C-s>', ':lua UpdateTmuxSessionInfo()<CR>', { noremap = true, silent = true })
end

-- Change diff source because of neovim update problem and faster update time
local function diff_source()
    ---@diagnostic disable-next-line: undefined-field
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
        }
    end
end

function M.config()

    ---@diagnostic disable: undefined-field, need-check-nil
    require("lualine").setup {
        options = {
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            globalstatus = true,
        },
        sections = {
            lualine_a = {},
            lualine_b = {
                { require("noice").api.status.mode.get, cond = require("noice").api.status.mode.has, color = { fg = "#ff9e64" }, },
                { "tabs", cond = function() return #vim.fn.gettabinfo() > 1 end, }
            },
            lualine_c = {
                "branch",
                { "diff", source = diff_source, symbols = { added = " ", modified = " ", removed = " " } }
            },
            lualine_x = {
                { function() return require("lsp-progress").progress() end, },
                "diagnostics",
                -- "copilot",
                "filetype",
            },
            lualine_y = {
                "progress"
            },
            lualine_z = { GetTmuxSession },
        },
        extensions = { "trouble", "nvim-dap-ui", "quickfix", "man", "fugitive" },
    }

    -- Listen lsp-progress event and refresh lualine (allows smoother lualine updating)
    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
    })

end


return M

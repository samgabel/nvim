-- Wrap
-- wrap text on screen
vim.api.nvim_create_user_command("Wrap", function()
    vim.wo.wrap = not vim.wo.wrap
    local state = vim.wo.wrap and "on" or "off"
    vim.notify("Wrapping toggled " .. state, vim.log.levels.INFO, { title = "wrap" })
end, {})

-- InlayHintToggle
-- toggle lsp inlay_hint globally
vim.api.nvim_create_user_command("InlayHintToggle", function()
    vim.api.nvim_set_hl(0, "LspInlayHint", { italic = true, fg = "#666666" })
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    local state = vim.lsp.inlay_hint.is_enabled() and "Enabled" or "Disabled"
    vim.notify("Inlay Hints " .. state, vim.log.levels.INFO, { title = "lsp" })
end, {})

-- DeleteListedBuffers
-- Function to delete all buffers listed in the `:buffers` vim command (not all the buffers listed in `:buffers!`)
vim.api.nvim_create_user_command("DeleteListedBuffers", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    local success = true
    local count = 0
    for _, buf in ipairs(buffers) do
        if buf.bufnr ~= current_buf then
            local modified = vim.api.nvim_get_option_value("modified", { buf = buf.bufnr })
            if modified then
                local path = vim.api.nvim_buf_get_name(buf.bufnr)
                local filename = vim.fn.expand("#" .. path .. ":h")
                vim.notify(filename .. " has unsaved changes. Not deleting.", vim.log.levels.WARN, {
                    title = "buffers",
                })
                success = false
            else
                vim.api.nvim_buf_delete(buf.bufnr, {})
                count = count + 1
            end
        end
    end
    if success == true and count > 0 then
        vim.notify("Successfully deleted " .. count .. " hanging buffers", vim.log.levels.INFO, {
            title = "buffers",
        })
    end
end, {})

-- ChezmoiPickTab
-- Pick a chezmoi-managed file in the current buffer, then open it in a new tab
vim.api.nvim_create_user_command("ChezmoiPickTab", function()
    local results = require("chezmoi.commands").list({
        args = {
            "--path-style", "absolute",
            "--include", "files",
            "--exclude", "externals",
        },
    })
    local items = {}
    for _, czFile in ipairs(results) do
        table.insert(items, { text = czFile, file = czFile })
    end
    require("snacks").picker.pick({
        items = items,
        confirm = function(picker, item)
            picker:close()
            vim.cmd("tabnew")
            require("chezmoi.commands").edit({
                targets = { item.text },
                args = { "--watch" },
            })
        end,
    })
end, {})

-- ChezmoiEditTab
-- Open the current buffer's chezmoi source file in a new tab (if managed)
vim.api.nvim_create_user_command("ChezmoiEditTab", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local managed = require("chezmoi.commands").source_path({
        targets = { filepath },
        args = {},
        on_stderr = function() end,
    })
    if not managed or not managed[1] or managed[1] == "" then
        vim.notify("Not a chezmoi-managed file: " .. filepath, vim.log.levels.WARN)
        return
    end
    vim.cmd("tabnew")
    require("chezmoi.commands").edit({ targets = { filepath }, args = { "--watch" } })
end, {})

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

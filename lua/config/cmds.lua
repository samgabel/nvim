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

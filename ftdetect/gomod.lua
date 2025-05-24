vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup('detect_gomod', { clear = true }),
    desc = 'Set filetype for gomod files',
    pattern = "go.mod",
    callback = function()
        vim.bo.filetype = 'gomod'
    end,
})


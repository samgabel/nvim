vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup('detect_conf', { clear = true }),
    desc = 'Set filetype for conf files',
    pattern = "*.conf",
    callback = function()
        vim.bo.filetype = 'conf'
    end,
})

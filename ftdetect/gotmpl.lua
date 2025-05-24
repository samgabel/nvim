vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup('detect_gotmpl', { clear = true }),
    desc = 'Set filetype for gotmpl files',
    pattern = "*.tmpl",
    callback = function()
        vim.bo.filetype = 'gotmpl'
    end,
})

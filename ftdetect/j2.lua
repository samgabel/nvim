vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup('detect_jinja', { clear = true }),
    desc = 'Set filetype for jinja2 files',
    pattern = { "*.j2" },
    callback = function()
        vim.bo.filetype = 'jinja'
    end,
})

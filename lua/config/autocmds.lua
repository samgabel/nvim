-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Highjack quickfix list and replace with trouble.nvim
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd([[cclose]])
        vim.cmd([[Trouble qflist open]])
      end)
    end
  end,
})

-- Use 'q' to close buf with certain files
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "",
        "dbout",
        "help",
        "lspinfo",
        "man",
        "neotest-output-panel",
        "neotest-output",
        "neotest-summary",
        "notify",
        "vim",
    },
    callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR>
            set nobuflisted
        ]])
    end,
})

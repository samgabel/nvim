-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Neo-Tree lazily highjack netrw
vim.api.nvim_create_autocmd('BufEnter', {
    -- make a group to be able to delete it later
    group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
    callback = function()
        local f = vim.fn.expand('%:p')
        if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd('Neotree current dir=' .. f)
            -- neo-tree is loaded now, delete the init autocmd
            vim.api.nvim_clear_autocmds{group = 'NeoTreeInit'}
        end
    end
})

-- Highjack quickfix list and replace with trouble.nvim
vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("TroubleQfHijack", { clear = true }),
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
    group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
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

-- Reload buffers changed on disk (e.g. external edits / chezmoi apply)
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "BufEnter", "TabEnter" }, {
    group = vim.api.nvim_create_augroup("CheckTimeReload", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" and vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
        end
    end,
})

-- Remove Trailing whitespaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup("TrimTrailingWhitespace", { clear = true }),
    pattern = '*',
    callback = function()
        local pos = vim.fn.getpos('.')
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos('.', pos)
    end,
})

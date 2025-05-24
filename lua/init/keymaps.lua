local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader Key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Jump-Motion alternative
-- <C-o> -> goes to previous cursor position
-- <C-p> -> goes to forward cursor position
keymap("n", "<C-p>", "<C-i>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<m-tab>", "<c-6>", opts)

-- Better <C-u> and <C-d> movement: keep cusor centered
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Better search navigation (search + press n or N)
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "gi", "gi<C-o>zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Pasting over code does not copy over that pasted over code to clipboard
keymap("x", "p", [["_dP]], opts)

-- Keeps `J` from moving cursor
keymap("n", "J", "mzJ`z", opts)

-- Quickfix Lists: display next item
keymap("n", "<M-j>", "<CMD>lua require('trouble').next({skip_groups = true, jump = true})<CR>zz", opts)
keymap("n", "<M-k>", "<CMD>lua require('trouble').previous({skip_groups = true, jump = true})<CR>zz", opts)

-- macOS style delete previous word in insert mode
keymap("i", "<M-BS>", "<C-w>", opts)
-- also <CMD-BS> is set to delete entire line in insert mode

-- NOTE: NO IDEA WHAT THESE DO >

vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Begining and End of line navigation in normal mode
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- Able to scroll "jk" onto wrapped lines instead of skipping over them
keymap({ "n", "x" }, "j", "gj", opts)
keymap({ "n", "x" }, "k", "gk", opts)

-- Remove insert-delete key (makes way for nvim-cmp snippet jumping)
vim.keymap.set('i', '<C-h>', '<Nop>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts)

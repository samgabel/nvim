-- KEYMAP UTILITIES
local keymap = vim.keymap.set
local function opts(message) return { noremap = true, silent = true, desc = message } end

-- LEADER KEY
keymap("n", "<Space>", "", opts(""))  -- Set space as leader key trigger
vim.g.mapleader = " "             -- Set global leader key
vim.g.maplocalleader = "\\"       -- Set local leader key

-- JUMP MOTION ALTERNATIVES
-- <C-o> goes to previous cursor position
-- <C-p> goes to forward cursor position (remapped here)
keymap("n", "<C-o>", "<C-o>", opts("Backward jump"))
keymap("n", "<C-p>", "<C-i>", opts("Forward jump"))

-- WINDOW NAVIGATION
keymap("n", "<C-h>",    "<C-w>h",   opts("Move to left window"))
keymap("n", "<C-j>",    "<C-w>j",   opts("Move to bottom window"))
keymap("n", "<C-k>",    "<C-w>k",   opts("Move to top window"))
keymap("n", "<C-l>",    "<C-w>l",   opts("Move to right window"))
keymap("n", "<m-tab>",  "<c-6>",    opts("Alternate file"))

-- SCROLLING
keymap("n", "<C-u>", "<C-u>zz", opts("Half-page up"))
keymap("n", "<C-d>", "<C-d>zz", opts("Half-page down"))

-- SEARCH NAVIGATION
keymap("n", "n",    "nzz",          opts("Next search result"))
keymap("n", "N",    "Nzz",          opts("Prev search result"))
keymap("n", "*",    "*zz",          opts("Search word forward"))
keymap("n", "#",    "#zz",          opts("Search word backward"))
keymap("n", "gi",   "gi<C-o>zz",    opts("Go to last insert position"))
-- keymap("n", "g*", "g*zz", opts)       -- Partial word search forward, centered
-- keymap("n", "g#", "g#zz", opts)       -- Partial word search backward, centered

-- VISUAL MODE INDENTATION
keymap("v", "<", "<gv", opts("Indent left, stay in visual"))
keymap("v", ">", ">gv", opts("Indent right, stay in visual"))

-- VISUAL MODE LINE MOVEMENT
keymap("v", "J", ":m '>+1<CR>gv=gv", opts("Move lines down"))
keymap("v", "K", ":m '<-2<CR>gv=gv", opts("Move lines up"))

-- PASTING
keymap("x", "p", [["_dP]], opts("Paste"))

-- JOIN LINES
keymap("n", "J", "mzJ`z", opts("Join lines"))

-- TROUBLE/QUICKFIX NAVIGATION
keymap("n", "<M-j>", "<CMD>lua require('trouble').next({mode = 'qflist', jump = true})<CR>zz", opts("Quickfix Next"))
keymap("n", "<M-k>", "<CMD>lua require('trouble').prev({mode = 'qflist', jump = true})<CR>zz", opts("Quickfix Prev"))

-- INSERT MODE EDITING
keymap("i", "<M-BS>", "<C-w>", opts("macOS delete previous word"))

-- MOUSE MENU
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>", opts("Right-click LSP menu"))
vim.keymap.set("n", "<Tab>",        "<cmd>:popup mousemenu<CR>", opts("Tab LSP menu"))

-- LINE NAVIGATION
keymap({ "n", "o", "x" }, "<s-h>", "^",     opts("Beginning of line"))
keymap({ "n", "o", "x" }, "<s-l>", "g_",    opts("End of line"))

-- WRAPPED LINE NAVIGATION
keymap({ "n", "x" }, "j", "gj", opts("Down"))
keymap({ "n", "x" }, "k", "gk", opts("Up"))

-- TERMINAL MODE
vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", opts("Exit terminal mode"))

-- DELETE KEYMAPS
vim.keymap.set('i', '<C-h>', '<Nop>', opts("Disable for cmp snippet jumping"))
vim.keymap.del({ "n", "v" },    "gra")
vim.keymap.del("n",             "gri")
vim.keymap.del("n",             "grr")
vim.keymap.del("n",             "grn")
vim.keymap.del("n",             "grt")
vim.keymap.del("n",             "gO")

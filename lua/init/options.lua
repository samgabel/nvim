vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:blinkon1,r-cr-o:hor20" -- cursor is set to block for all modes except replace modes
vim.opt.guicursor = "n-v-c-sm:block,i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20" -- cursor styles default
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
-- vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = false -- highlight all matches on previous search pattern
vim.opt.incsearch = true -- smarter search we can do things like: " vim.* = "
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 0 -- transparency for popups (like cmp) -> higher is more transparency
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- don't show tabs in tabline anymore
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 50 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
-- GLOBAL INDENTATION --
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.cmd("set invlist") -- sets the tab literal character visibility on
vim.opt.listchars = { tab = "»⠀", trail = "•"} -- formats the trailing dot when typing and the literal tab character
vim.opt.cursorline = true -- highlight the current line
vim.opt.cursorlineopt = "number"
vim.opt.number = true -- set numbered lines
vim.opt.laststatus = 3 -- set lualine behavior
vim.opt.showcmd = false -- we are using mini.nvim (from noice.nvim)
vim.opt.ruler = false -- disable line and column number in status line
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 8 -- num of lines to keep above and below cursor when moving
vim.opt.sidescrolloff = 8 -- num of lines to keep when moving side to side
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.title = false
-- colorcolumn = "80",
-- colorcolumn = "120",
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append {
    stl = " ",
}

vim.opt.shortmess:append "c" -- cleaner UI for quickfix lists

vim.opt.whichwrap:append "h,l" -- use vim motions in Normal to go to next line when at the end of the current line and vice-versa
vim.opt.iskeyword:append "-" -- selects a word with "-" in-between as a full word, before it would treat the word as 2 words

-- vim.opt.autoindent = true -- (idk if this works) indents line automatically when pressing <CR> in Insert mode or "o" in Normal mode
vim.opt.linebreak = true -- will stop wrapping lines in the middle of the word
vim.opt.breakindent = true -- respects indentation when soft wrapping lines

-- BACKUP AND SWAP
vim.opt.backup = false        -- Disable creation of backup files
vim.opt.swapfile = false      -- Disable creation of swap files
vim.opt.writebackup = false   -- Disable write backup (prevents editing conflicts)

-- CLIPBOARD
vim.opt.clipboard = "unnamedplus"  -- Allow Neovim to access the system clipboard

-- CURSOR
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:blinkon1,r-cr-o:hor20"  -- Alternative cursor styles
vim.opt.guicursor = "n-v-c-sm:block,i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150,r-cr-o:hor20"  -- Default cursor styles with blinking

-- COMMAND LINE
vim.opt.cmdheight = 1  -- Set command line height to 1 for more space

-- COMPLETION
vim.opt.completeopt = { "menuone", "noselect" }  -- Completion options, mainly for cmp plugin

-- SEARCH
vim.opt.hlsearch = false   -- Disable highlighting of all matches on previous search
vim.opt.incsearch = true   -- Enable incremental search for smarter searching
vim.opt.ignorecase = true  -- Ignore case in search patterns
vim.opt.smartcase = true   -- Enable smart case (case-sensitive if uppercase used)

-- MOUSE
vim.opt.mouse = "a"  -- Enable mouse support in all modes

-- POPUP MENU
vim.opt.pumheight = 10  -- Set popup menu height to 10
vim.opt.pumblend = 0    -- Set popup transparency (0 = no transparency)

-- UI ELEMENTS
vim.opt.showmode = false   -- Hide mode indicator (e.g., -- INSERT --)
vim.opt.showtabline = 0    -- Hide tab line
vim.opt.title = false      -- Disable window title setting

-- WINDOW SPLITS
vim.opt.splitbelow = true  -- Open horizontal splits below current window
vim.opt.splitright = true  -- Open vertical splits to the right of current window

-- COLORS
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors in terminal

-- TIMING
vim.opt.timeoutlen = 1000  -- Time to wait for mapped sequence completion (ms)
vim.opt.updatetime = 50    -- Faster completion update time (default 4000ms)

-- UNDO
vim.opt.undofile = true  -- Enable persistent undo across sessions

-- INDENTATION
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.shiftwidth = 4     -- Number of spaces for each indentation level
vim.opt.tabstop = 4        -- Number of spaces a tab represents
vim.opt.smartindent = true -- Enable smart indentation

-- VISUAL ELEMENTS
vim.cmd("set invlist")                    -- Toggle visibility of tab characters
vim.opt.listchars = { tab = "»⠀", trail = "•" }  -- Customize display of tabs and trailing spaces
vim.opt.cursorline = true                 -- Highlight the current line
vim.opt.cursorlineopt = "number"          -- Highlight only the line number

-- LINE NUMBERS
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.numberwidth = 2       -- Set width of number column (default 4)

-- STATUS LINE
vim.opt.laststatus = 3    -- Global status line (for lualine)
vim.opt.showcmd = false   -- Hide command in status line (using noice/mini)
vim.opt.ruler = false     -- Hide ruler (line/column info)

-- SIGN COLUMN
vim.opt.signcolumn = "yes"  -- Always show sign column to prevent text shifting

-- TEXT WRAPPING
vim.opt.wrap = false       -- Disable line wrapping
vim.opt.linebreak = true   -- Break lines at word boundaries
vim.opt.breakindent = true -- Maintain indentation on wrapped lines

-- TREESITTER FOLDING
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99  --  Expands folds because default is everything folded

-- SCROLLING
vim.opt.scrolloff = 8     -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- FONT
vim.opt.guifont = "monospace:h17"  -- Font for graphical Neovim (ignored in terminal)

-- FILL CHARACTERS
vim.opt.fillchars:append({ eob = " ", stl = " " }) -- Space for status line

-- MESSAGES
vim.opt.shortmess:append("sc")  -- Shorter messages for cleaner UI

-- MOTIONS
vim.opt.whichwrap:append "h,l"  -- Allow h/l to wrap to next/previous line

-- KEYWORDS
vim.opt.iskeyword:append "-"  -- Treat words with hyphens as single words

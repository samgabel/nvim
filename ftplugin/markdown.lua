-- wrapping enabled
vim.opt_local.wrap = true
-- spelling enabled
vim.opt_local.spell = true
-- https://miikanissi.com/blog/grammar-and-spell-checker-in-nvim/
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add" -- creates a wordlist of "good" and "wrong" words used by vim spelling
-- https://vimways.org/2018/formatting-lists-with-vim/
vim.opt_local.breakindentopt = "list:-1" -- matches indentation to each wrapped line (uses the length of a match with 'formatlistpat')
-- markdown list symbols declaration
vim.opt_local.formatlistpat = "^\\s*[-*+>]\\s\\+\\|^\\s*\\d\\+[\\).]\\s*" -- works with `breakindentopt` (in lua/init/options)
-- conceal quotes and code block delimiters
vim.opt_local.conceallevel = 1 -- conceals things like code block (```), bold (**), and full path links in .md notes
-- vim.opt.concealcursor = "nc" -- works with conceallevel

local icons = require("user.icons")
-- Colors: azure, blue, cyan, green, grey, orange, purple, red, yellow

return {
    keymaps = {
        -- GENERAL --
        {
            -- Single
            {
                "<leader>q",
                ":confirm q <CR>",
                desc = "Quit",
            },
            {
                "<leader>w",
                "<CMD>Wrap<CR>",
                desc = "Wrap",
                icon = { icon = icons.misc.Wrap }
            },
            {
                "<leader>b",
                "<CMD>NoiceDismiss<CR>",
                desc = "Dismiss",
                icon = { icon = icons.misc.Ghost }
            },
            {
                "<leader>x",
                "<CMD>DeleteListedBuffers<CR>",
                desc = "Delete Buffers",
            },
            {
                "<C-t>",
                "<CMD>pop<CR><CMD>tags<CR>",
                desc = "Tag Pop",
            },
            {
                "<M-t>",
                "<CMD>tag<CR><CMD>tags<CR>",
                desc = "Tag Forward",
            },
            -- Groups
            {
                "gl",
                group = "Lsp",
                icon = { icon = icons.kind.Value, color = "purple" },
            },
            {
                "glc",
                group = "Calls",
                icon = { icon = icons.kind.Function, color = "purple" },
            },
            {
                "<leader>h",
                group = "Ai",
                icon = { icon = icons.misc.Robot, color = "red" },
                mode = { "n", "v" },
            },
            {
                "<leader>s",
                group = "Side",
                icon = { icon = icons.ui.Note, color = "grey" },
            },
            {
                "<leader>f",
                group = "Find",
            },
            {
                "<leader>g",
                group = "Git",
            },
            {
                "<leader>gG",
                group = "GitHub",
                icon = { icon = icons.git.Octoface, color = "purple" },
            },
            {
                "<leader>c",
                group = "Chezmoi",
                icon = { icon = icons.misc.Chef, color = "orange" },
            },
        },
        -- LSPCONFIG --
        {
            {
                "K",
                "<CMD>lua vim.lsp.buf.hover()<CR>",
                desc = "Hover",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "gd",
                "<CMD>lua vim.lsp.buf.definition()<CR>",
                desc = "Definition",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "gD",
                "<CMD>lua vim.lsp.buf.declaration()<CR>",
                desc = "Declaration",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "gla",
                "<CMD>lua vim.lsp.buf.code_action()<CR>",
                desc = "Code Action",
                icon = { icon = icons.kind.Component, color = "orange" },
                mode = { "n", "v" },
            },
            {
                "glf",
                "<CMD>lua vim.lsp.buf.format()<CR>",
                desc = "Format",
                icon = { icon = icons.kind.Object, color = "orange" },
            },
            {
                "gld",
                "<CMD>Trouble diagnostics_buffer toggle<CR>",
                desc = "Diagnostic (Buffer)",
                icon = { icon = icons.ui.Note, color = "azure" },
            },
            {
                "glD",
                "<CMD>Trouble diagnostics toggle<CR>",
                desc = "Diagnostic (Global)",
                icon = { icon = icons.ui.Note, color = "blue" },
            },
            {
                "gll",
                "<CMD>lua vim.diagnostic.open_float()<CR>",
                desc = "Diagnostic Float",
                icon = { icon = icons.ui.Note, color = "grey" },
            },
            {
                "glj",
                "<CMD>lua vim.diagnostic.jump({ count = 1, float = true })<CR>",
                desc = "Diagnostic Next",
                icon = { icon = icons.ui.BoldArrowRight, color = "orange" },
            },
            {
                "glk",
                "<CMD>lua vim.diagnostic.jump({ count = -1, float = true })<CR>",
                desc = "Diagnostic Prev",
                icon = { icon = icons.ui.BoldArrowLeft, color = "orange" },
            },
            {
                "glo",
                "<CMD>Outline<CR>",
                desc = "Symbols",
                icon = { icon = icons.kind.Keyword, color = "purple" },
            },
            {
                "glh",
                "<CMD>InlayHintToggle<CR>",
                desc = "Inlay Hint",
                icon = { icon = icons.diagnostics.Hint, color = "yellow" },
            },
            {
                "gli",
                "<CMD>lua vim.lsp.buf.implementation()<CR>",
                desc = "Implementations",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "glr",
                "<CMD>lua vim.lsp.buf.references()<CR>",
                desc = "References",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "gln",
                "<CMD>lua vim.lsp.buf.rename()<CR>",
                desc = "Rename",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "glt",
                "<CMD>lua vim.lsp.buf.type_definition()<CR>",
                desc = "Type Definition",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "glci",
                "<CMD>lua vim.lsp.buf.incoming_calls()<CR>",
                desc = "Incoming",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
            {
                "glco",
                "<CMD>lua vim.lsp.buf.outgoing_calls()<CR>",
                desc = "Outgoing",
                icon = { icon = icons.diagnostics.Diagnostic, color = "cyan" },
            },
        },
        -- NEO-TREE --
        {
            {
                "<leader>e",
                "<CMD>Neotree focus current reveal_force_cwd<CR>",
                desc = "Filesystem",
                icon = { icon = icons.ui.FileSymlink, color = "yellow" },
            },
            {
                "<leader>se",
                "<CMD>Neotree toggle left<CR>",
                desc = "Filesystem",
                icon = { icon = icons.ui.FileSymlink, color = "yellow" },
            },
        },
        -- GITSIGNS --
        {
            -- Diff
            {
                "<leader>gd",
                "<CMD>belowright Gitsigns diffthis HEAD<CR>",
                desc = "Diff",
                icon = { icon = icons.git.Diff, color = "cyan" },
            },
            -- Hunk
            {
                "<leader>gp",
                "<CMD>lua require 'gitsigns'.preview_hunk()<CR>",
                desc = "Hunk Preview",
                icon = { icon = icons.ui.Stacks, color = "cyan" },
            },
            {
                "<leader>gj",
                "<CMD>lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>",
                desc = "Hunk Next",
                icon = { icon = icons.git.FileRenamed, color = "cyan" },
            },
            {
                "<leader>gk",
                "<CMD>lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>",
                desc = "Hunk Prev",
                icon = { icon = icons.git.FileRenamedBack, color = "cyan" },
            },
            {
                "<leader>gs",
                "<CMD>w<CR><CMD>lua require 'gitsigns'.stage_hunk()<CR>",
                desc = "Hunk Stage",
                icon = { icon = icons.git.LineAdded, color = "cyan" },
            },
            {
                "<leader>gr",
                "<CMD>lua require 'gitsigns'.reset_hunk()<CR>",
                desc = "Hunk Reset",
                icon = { icon = icons.git.LineRemoved, color = "cyan" },
            },
            {
                "<leader>gu",
                "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>",
                desc = "Hunk Undo Stage",
                icon = { icon = icons.git.LineModified, color = "cyan" },
            },
            -- Buffer
            {
                "<leader>gS",
                "<CMD>w<CR><CMD>lua require 'gitsigns'.stage_buffer()<CR>",
                desc = "Buffer Stage",
                icon = { icon = icons.git.LineAdded, color = "cyan" },
            },
            {
                "<leader>gR",
                "<CMD>lua require 'gitsigns'.reset_buffer()<CR>",
                desc = "Buffer Reset",
                icon = { icon = icons.git.LineRemoved, color = "cyan" },
            },
        },
        -- SNACKS --
        {
            -- Picker
            {
                "<leader>ff",
                "<CMD>lua Snacks.picker.files()<CR>",
                desc = "Files",
                icon = { icon = icons.ui.FindFile, color = "cyan" },
            },
            {
                "<leader>fs",
                "<CMD>lua Snacks.picker.grep()<CR>",
                desc = "Text",
                icon = { icon = icons.ui.FindText, color = "cyan" },
            },
            {
                "<leader>fc",
                "<CMD>lua Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })<CR>",
                desc = "Todo",
                icon = { icon = icons.misc.Time, color = "cyan" },
            },
            {
                "<leader>fb",
                "<CMD>lua Snacks.picker.buffers()<CR>",
                desc = "Buffers",
                icon = { icon = icons.ui.Table, color = "purple" },
            },
            {
                "<leader>fo",
                "<CMD>lua Snacks.picker.lsp_symbols()<CR>",
                desc = "LSP Symbols",
                icon = { icon = icons.kind.Function, color = "orange" },
            },
            {
                "<leader>fO",
                "<CMD>lua Snacks.picker.lsp_workspace_symbols()<CR>",
                desc = "LSP W Symbols",
                icon = { icon = icons.kind.Function, color = "orange" },
            },
            {
                "<leader>fe",
                "<CMD>lua Snacks.picker.notifications()<CR>",
                desc = "Vim Errors",
                icon = { icon = icons.ui.Bug, color = "red" },
            },
            {
                "<leader>fh",
                "<CMD>lua Snacks.picker.help()<CR>",
                desc = "Help",
                icon = { icon = icons.ui.Files, color = "grey" },
            },
            {
                "<leader>fl",
                "<CMD>lua Snacks.picker.resume()<CR>",
                desc = "Last",
                icon = { icon = icons.ui.Search, color = "green" },
            },
            -- Git
            {
                "<leader>gl",
                "<CMD>lua Snacks.git.blame_line()<CR>",
                desc = "Blame",
                icon = { icon = icons.git.Git, color = "orange" },
            },
            {
                "<leader>go",
                "<CMD>lua Snacks.gitbrowse.open()<CR>",
                desc = "Browse",
                icon = { icon = icons.git.Git, color = "orange" },
            },
            {
                "<leader>gf",
                "<CMD>lua Snacks.lazygit.log_file()<CR>",
                desc = "File Log",
                icon = { icon = icons.git.Diff, color = "yellow" },
            },
            {
                "<leader>gg",
                "<CMD>lua Snacks.lazygit.open()<CR>",
                desc = "Lazygit",
                icon = { icon = icons.git.Branch, color = "yellow" },
            },
            -- GitHub
            {
                "<leader>gGi",
                "<CMD>lua Snacks.picker.gh_issue()<CR>",
                desc = "Issues (Open)",
                icon = { icon = icons.git.Octoface, color = "blue" },
            },
            {
                "<leader>gGI",
                "<CMD>lua Snacks.picker.gh_issue({ state = 'all' })<CR>",
                desc = "Issues (All)",
                icon = { icon = icons.git.Octoface, color = "blue" },
            },
            {
                "<leader>gGp",
                "<CMD>lua Snacks.picker.gh_pr()<CR>",
                desc = "PRs (Open)",
                icon = { icon = icons.git.Octoface, color = "purple" },
            },
            {
                "<leader>gGP",
                "<CMD>lua Snacks.picker.gh_pr({ state = 'all' })<CR>",
                desc = "PRs (All)",
                icon = { icon = icons.git.Octoface, color = "purple" },
            },
        },
        -- ILLUMINATE --
        {
            {
                "<M-n>",
                desc = "Next Illuminated Textobject",
                icon = { icon = icons.ui.BoldArrowRight, color = "grey" },
            },
            {
                "<M-p>",
                desc = "Prev Illuminated Textobject",
                icon = { icon = icons.ui.BoldArrowLeft, color = "grey" },
            },
        },
        -- OPENCODE --
        {
            {
                "<leader>ha",
                "<CMD>lua require('opencode').ask('@this: ')<CR>",
                desc = "Ask Line",
                icon = { icon = icons.misc.Robot, color = "green" },
                mode = { "n", "v" },
            },
            {
                "<leader>hf",
                "<CMD>lua require('opencode').ask('@buffer: ')<CR>",
                desc = "Ask File",
                icon = { icon = icons.misc.Robot, color = "green" },
            },
            {
                "<leader>hq",
                "<CMD>lua require('opencode').ask('@quickfix: ')<CR>",
                desc = "Ask Qflist",
                icon = { icon = icons.misc.Robot, color = "green" },
            },
            {
                "<leader>hd",
                "<CMD>lua require('opencode').ask('@diagnostics: ')<CR>",
                desc = "Ask Diagnostics",
                icon = { icon = icons.misc.Robot, color = "green" },
            },
            {
                "<leader>hs",
                "<CMD>lua require('opencode').select()<CR>",
                desc = "Execute Action",
                icon = { icon = icons.misc.Robot, color = "orange" },
                mode = { "n", "v" },
            },
            {
                "<leader>hu",
                "<CMD>lua require('opencode').command('session.undo')<CR>",
                desc = "Undo",
                icon = { icon = icons.misc.Robot, color = "yellow" },
            },
            {
                "<leader>hr",
                "<CMD>lua require('opencode').command('session.redo')<CR>",
                desc = "Redo",
                icon = { icon = icons.misc.Robot, color = "yellow" },
            },
            {
                "<leader>ht",
                "<CMD>lua require('user.opencode.tmux-provider').toggle()<CR>",
                desc = "Toggle Opencode",
                icon = { icon = icons.misc.Robot, color = "red" },
            },
            {
                "<leader>hp",
                "<CMD>PerlesRoot<CR>",
                desc = "Perles",
                icon = { icon = icons.kind.Reference, color = "red" },
            },
        },
        -- CHEZMOI --
        {
            {
                "<leader>cl",
                "<CMD>ChezmoiPickTab<CR>",
                desc = "List",
                icon = { icon = icons.misc.Robot, color = "green" },
                mode = { "n", "v" },
            },
            {
                "<leader>ce",
                "<CMD>ChezmoiEditTab<CR>",
                desc = "Edit",
                icon = { icon = icons.misc.Robot, color = "green" },
            },
        },
    },
}

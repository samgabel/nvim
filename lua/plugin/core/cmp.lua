local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            event = "InsertEnter",
        },
        {
            -- TODO: replace with "https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources#icons-symbols-and-emojis"
            -- also look at AI and GIT (conventional commits)
            "hrsh7th/cmp-emoji",
            event = "InsertEnter",
        },
        {
            "hrsh7th/cmp-buffer",
            event = "InsertEnter",
        },
        {
            "hrsh7th/cmp-path",
            event = "InsertEnter",
        },
        {
            "hrsh7th/cmp-cmdline",
            event = "InsertEnter",
        },
        {
            "saadparwaiz1/cmp_luasnip",
            event = "InsertEnter",
        },
        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            dependencies = {
                "rafamadriz/friendly-snippets",
            },
        },
        {
            "hrsh7th/cmp-nvim-lua",
        },
    },
}

function M.config()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip/loaders/from_vscode").lazy_load()

    -- CUSTOM HIGHLIGHT GROUPS -------------------------------------------------------------------------------

    -- [VSCODE] ------------------------------------------------------------------
    -- gray
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
    -- blue
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
    -- light blue
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
    -- pink
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
    -- front
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

    -- [NON VSCODE] --------------------------------------------------------------
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#D8BFD8" })
    vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })


    -- [SETUP] ----------------------------------------------------------------------------------------------

    local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    local icons = require "user.icons"

    cmp.setup {
        preselect = cmp.PreselectMode.None, -- turns off preselect for cmp menu (mainly for weird gopls behavior)

        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },

        -- [MAPPING] ---------------------------------
        mapping = cmp.mapping.preset.insert {
            -- menu selection next/prev
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),

            -- menu scroll document
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),

            -- enable/disable menu
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },

            -- accept currently selected item. If none selected, `select` first item.
            ["<CR>"] = cmp.mapping.confirm { select = true }, -- set `select` to `false` to only confirm explicitly selected items.

            -- snippet selection next/prev
            ["<C-l>"] = cmp.mapping(function(fallback)
                if luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, { "i", "s", }),
            ["<C-h>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s", }),
        },

        -- [FORMATTING] --------------------------------
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
            -- fields = { "abbr", "menu", "kind" },
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s %s', icons.kind[vim_item.kind], vim_item.kind) -- these are the cmp window items
                vim_item.menu = ({
                    nvim_lsp = "",
                    nvim_lua = "",
                    luasnip = "",
                    buffer = "",
                    path = "",
                    emoji = "",
                    cmdline = "",
                })[entry.source.name]

                -- custom icons & highlight groups --
                if entry.source.name == "luasnip" then
                    vim_item.kind = icons.kind.Event
                    vim_item.kind_hl_group = "CmpItemKindSnippet"
                end

                if entry.source.name == "cmdline" then
                    vim_item.kind = ""
                    vim_item.kind_hl_group = "CmpItemKindText"
                end

                if entry.source.name == "cmp_tabnine" then
                    vim_item.kind = icons.misc.Robot
                    vim_item.kind_hl_group = "CmpItemKindTabnine"
                end

                if entry.source.name == "emoji" then
                    vim_item.kind = icons.misc.Smiley
                    vim_item.kind_hl_group = "CmpItemKindEmoji"
                end

                return vim_item
            end,
        },
        -- CMP inmport sources --
        sources = {
            { name = "copilot" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "cmp_tabnine" },
            { name = "nvim_lua" },
            { name = "buffer" },
            { name = "path" },
            { name = "calc" },
            { name = "emoji" },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        -- CMP window settings --
        window = {
            completion = {
                border = "rounded",
                scrollbar = false,
                -- cmp window border color = blue
                winhighlight = "FloatBorder:Keyword",
            },
            documentation = {
                border = "rounded",
                -- cmp window border color = blue
                winhighlight = "FloatBorder:Function",
            },
        },
        -- CMP ghost text --
        experimental = {
            ghost_text = true,
        },
    }

    -- [FILETYPE SPECIFIC] ----------------------------------------------------------------------------------

    -- For vim-dadbod cmp sql query completions
    cmp.setup.filetype({ "sql" }, {
        sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
        },
    })


    -- [DEPENDECY SOURCES] ----------------------------------------------------------------------------------

    -- Use buffer *source* for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path *source* for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })


end

return M

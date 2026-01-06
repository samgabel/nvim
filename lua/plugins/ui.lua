return {



-- ========================================================================================
-- NOICE -> UI MESSAGES/CMDLINE/POPUP
-- ========================================================================================
    {
        "folke/noice.nvim",
        lazy = false,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim"
        },
        config = function()
            require("noice").setup {
                cmdline = {
                    view = "cmdline",
                    format = {
                        cmdline = { icon = " " },
                        search_up = { icon = " " },
                        search_down = { icon = " " },
                        filter = { icon = " " },
                        help = { icon = " " },
                        lua = { icon = " " },
                    },
                },
                messages = {
                    enabled = true,
                },
                popupmenu = {
                    enabled = true,
                },
                smart_move = {
                    enabled = false,
                },
                lsp = {
                    progress = {
                        enabled = false,
                    },
                },
                presets = {
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
                routes = {
                    -- Note: %d -> for numbers | %a -> for alphanumeric | (.) -> for any except newline
                    -- Note: adding `+` will extend this for one or more characters, ie: %a+%d+ | (.+)
                    -- Remove notification for writing, deletion, and undo/redo operations
                    {
                        filter = {
                            event = "msg_show",
                            -- kind will remove all empty message kinds (doesn't work with nvim-dap when notify is enabled)
                            -- kind = ""
                            any = {
                                { find = ":!(.+)" },                -- command messages
                                { find = "%d lines yanked" },           -- yanking
                                { find = "%d lines moved" },            -- moved
                                { find = "%d lines indented" },         -- indented
                                -- { find = "^/[^/]+" },                   -- searching (impossible to hide failed msg without blocking succesfull msg)
                                { find = "%d+L, %d+B" },                -- file update
                                { find = "\"(.+)\" (.+) written" },     -- writing
                                { find = "; after #%d+" },              -- redo
                                { find = "; before #%d+" },             -- undo
                                { find = "%d fewer lines" },            -- deletion
                                { find = "%d more lines" },             -- paste
                                { find = "%d lines (.*)ed %d time" },   -- indenting & outdenting
                                { find = "DB: Query '(.*)'" },          -- vim-dadbod-ui "finished in ..."
                            }
                        },
                        opts = { skip = true },
                    },
                    -- notify message filtering
                    {
                        filter = {
                            event = "notify",
                            any = {
                                -- Neotree
                                { find = "Toggling hidden files:" },
                                { find = "Cut (.+) to clipboard" },
                                { find = "Copied (.+) to clipboard" },
                                { find = "Renamed (.+) successfully" },
                                { find = "No items, skipping git ignored/status lookups"},
                                -- LSPConfig
                                { find = "No information available" },
                                -- Neotest
                                { find = "Starting watcher for (.+)" },
                                { find = "Watcher running for (.+)" },
                                { find = "Stopping watch for (.+)" },
                                -- Compiler
                                { find = "SUCCESS - (.+)" },
                                { find = "FAILURE - (.+)" },
                            }
                        },
                        opts = { skip = true },
                    },
                }
            }
        end
    },



-- ========================================================================================
-- LUALINE -> STATUS BAR
-- ========================================================================================
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufRead", "BufNewFile", "StdinReadPre" },
        ft = { "neo-tree" },
        dependencies = {
            "linrongbin16/lsp-progress.nvim",
        },
        config = function()
            -- Change diff source because of neovim update problem and faster update time
            local function diff_source()
                ---@diagnostic disable-next-line: undefined-field
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed
                    }
                end
            end
            require("lualine").setup {
                options = {
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {
                        { require("noice").api.status.mode.get, cond = require("noice").api.status.mode.has, color = { fg = "#ff9e64" }, },
                        { "tabs", cond = function() return #vim.fn.gettabinfo() > 1 end, }
                    },
                    lualine_c = {
                        "branch",
                        { "diff", source = diff_source, symbols = { added = " ", modified = " ", removed = " " } }
                    },
                    lualine_x = {
                        { function() return require("lsp-progress").progress() end, },
                        "diagnostics",
                        "filetype",
                    },
                    lualine_y = {
                        "progress"
                    },
                    -- lualine_z = { GetTmuxSession },
                },
                extensions = { "trouble", "nvim-dap-ui", "quickfix", "man", "fugitive" },
            }
            -- Listen lsp-progress event and refresh lualine (allows smoother lualine updating)
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end
    },



-- ========================================================================================
-- LSP-PROGRESS -> LSP LOADING BAR
-- ========================================================================================
    {
        "linrongbin16/lsp-progress.nvim",
        lazy = true,
        config = function()
            require("lsp-progress").setup {
                max_size = 50,
                client_format = function(client_name, spinner, series_messages)
                    if #series_messages == 0 then
                        return nil
                    end
                    return {
                        name = client_name,
                        body = spinner .. " " .. table.concat(series_messages, ", "),
                    }
                end,
                format = function(client_messages)
                    --- @param name string
                    --- @param msg string?
                    --- @return string
                    local function stringify(name, msg)
                        return msg and string.format("%s %s", name, msg) or name
                    end
                    local sign = " " -- nf-fa-gear \uf013
                    local bufnr = vim.api.nvim_get_current_buf()
                    local lsp_clients = vim.lsp.get_clients({ bufnr = bufnr })
                    local messages_map = {}
                    for _, climsg in ipairs(client_messages) do
                        messages_map[climsg.name] = climsg.body
                    end
                    if #lsp_clients > 0 then
                        table.sort(lsp_clients, function(a, b)
                            return a.name < b.name
                        end)
                        local builder = {}
                        for _, cli in ipairs(lsp_clients) do
                            if type(cli) == "table" and type(cli.name) == "string" and string.len(cli.name) > 0 then
                                if messages_map[cli.name] then
                                    table.insert(builder, stringify(cli.name, messages_map[cli.name]))
                                else
                                    table.insert(builder, stringify(cli.name))
                                end
                            end
                        end
                        if #builder > 0 then
                            return sign .. " " .. table.concat(builder, " / ")
                        end
                    end
                    return ""
                end,
            }
        end
    },



-- ========================================================================================
-- WEB-DEVICONS -> ICONS USED BY OTHER PLUGINS
-- ========================================================================================
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            require("nvim-web-devicons").setup({
                override_by_filename = {
                    ["go"] = {
                        icon = "",
                        color = "#519aba",
                        name = "go"
                    },
                    ["makefile"] = {
                        icon = "",
                        color = "#d97706",
                        name = "make"
                    },
                    ["go.mod"] = {
                        icon = "",
                        color = "#FF0090",
                        name = "gomod"
                    },
                    ["go.sum"] = {
                        icon = "",
                        color = "#FF0090",
                        name = "gosum"
                    },
                    ["asm"] = {
                        icon = "",
                        color = "#5f43e9",
                        name = "asm"
                    },
                }
            })
        end
    },



}

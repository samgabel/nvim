local M = {
    "Wansmer/symbol-usage.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'}
}


function M.config()

    local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

    -- -- hl-groups can have any name
    vim.api.nvim_set_hl(0, "SymbolUsageContentRef", { fg = "#B9DEFF", italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageContentDef", { fg = "#B9FFE9", italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageContentImpl", { fg = "#EED5FE", italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("@keyword.export").fg, italic = true })
    vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword.return").fg, italic = true })

    local function text_format(symbol)
        local res = {}

        if symbol.references then
            local usage = symbol.references <= 1 and "ref" or "refs"
            local num = symbol.references == 0 and "no" or symbol.references
            table.insert(res, { "󰌹 ", "SymbolUsageRef" })
            table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContentRef" })
        end

        if symbol.definition then
            if #res > 0 then
                table.insert(res, { " ", "NonText" })
            end
            local usage = symbol.definition <= 1 and "def" or "defs"
            local num = symbol.definition == 0 and "no" or symbol.definition
            table.insert(res, { "󰳽 ", "SymbolUsageDef" })
            table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContentDef" })
        end

        if symbol.implementation then
            if #res > 0 then
                table.insert(res, { " ", "NonText" })
            end
            local usage = symbol.implementation <= 1 and "impl" or "impls"
            local num = symbol.implementation == 0 and "no" or symbol.implementation
            table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
            table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContentImpl" })
        end

        return res
    end

    -------------------- CUSTOM SETUP HIGHJACK --------------------

    local u = require('symbol-usage.utils')
    local options = require('symbol-usage.options')
    local buf = require('symbol-usage.buf')

    local function setup_modified(opts)
        options.update(opts or {})

        vim.api.nvim_create_autocmd({ 'LspAttach' }, {
            group = u.GROUP,
            callback = function(event)
                buf.attach_buffer(event.buf)
            end,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = u.GROUP,
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.name == "null-ls" then
                    return -- Exit early if null-ls is detaching
                end
                buf.clear_buffer(event.buf) -- Proceed if it's not null-ls
            end,
        })
    end

    -- Assuming 'M' is the module where the original setup function is defined
    M.setup = setup_modified
    ---------------------------------------------------------------

    -- require block
    ---@diagnostic disable-next-line: missing-fields
    setup_modified({
        text_format = text_format,
        vt_position = 'end_of_line',
        vt_priority = 10000,
        references = { enabled = true, include_declaration = false },
        definition = { enabled = true },
        implementation = { enabled = true },
        -- Disable dockerfile symbols
        disable = {
            cond = {
                function()
                    return vim.fn.expand("%:p"):match(".*[dD]ockerfile.*$")
                end,
            },
        },
    })

end


return M

--------------------------------------- MACOS--------------------------------------
-- used in the init.lua so that we do not source plugins only meant for my main machine
function IsDarwin()
    local result = vim.fn.system("uname -s")
    return result:match("Darwin") ~= nil
end

--------------------------------------- FIXX --------------------------------------
-- on linux seems to throw error on "VimLeave", this fixes the error --
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        vim.fn.jobstart('notify-send "hello"', {detach=true})
    end,
})

--------------------------------------- WRAP --------------------------------------
vim.api.nvim_create_user_command("Wrap", function()
    local notify = require("notify")
    vim.wo.wrap = not vim.wo.wrap
    local state = vim.wo.wrap and "on" or "off"
    notify("Wrapping toggled " .. state, "info", {
        title = "wrap"
    })
end, {})

--------------------------------------- CHMOD -------------------------------------
vim.api.nvim_create_user_command("Chmod", function()
    local notify = require("notify")
    -- Get the current file name
    local path = vim.fn.expand("%:p")  -- Get the full path of the current file
    local file_name = vim.fn.expand("%:t")

    -- Check the current file permissions
    local file_perm = vim.fn.system("stat -f %Mp%Lp " .. path)

    -- Check if the last digit is odd (executable) or even (not executable)
    local is_executable = tonumber(file_perm) % 2 == 1

    if is_executable then
        -- If executable, remove executable permission
        os.execute("chmod -x " .. path)
        notify("Removed executable permission from " .. file_name, "info", {
            title = "chmod"
        })
    else
        -- If not executable, add executable permission
        os.execute("chmod +x " .. path)
        notify("Added executable permission to " .. file_name, "info", {
            title = "Chmod"
        })
    end
end, {})

--------------------------------------- PATH --------------------------------------

-- Function to paste absolute path inline
-- Keybind: <leader>pa
-- File: init.functions
function PasteFilePathInline()
    local file_path = vim.fn.expand "%:p" -- Get the full path of the current file
    ---@diagnostic disable-next-line: unused-local
    local cursor_pos = vim.fn.col "." -- Get the current cursor position
    -- Insert the full path at the cursor position in the current line
    vim.api.nvim_put({ file_path }, "c", true, true)
end

-- Function to paste relative path inline
-- Keybind: <leader>pr
-- File: init.functions
function PasteRelativePathInline()
    local file_path = vim.fn.expand "%" -- Get the relative path of the current file
    ---@diagnostic disable-next-line: unused-local
    local cursor_pos = vim.fn.col "." -- Get the current cursor position
    -- Insert the relative path at the cursor position in the current line
    vim.api.nvim_put({ file_path }, "c", true, true)
end

--------------------------------------- TMUX --------------------------------------
---@diagnostic disable: need-check-nil

-- Store tmux session name
local tmux_session_name = ""
-- Store tmux session zoom state
-- @default False
local tmux_zoomed = false

-- Get tmux session name and zoom status
-- @return The session name [and (󰍉) if pane is zoomed]
-- File: init.functions
function GetTmuxSession()
    return tmux_session_name .. (tmux_zoomed and " (󰍉)" or "")
end

-- Function to update tmux session name and zoom state
-- File: init.functions
function UpdateTmuxSessionInfo()
    local handle = io.popen "tmux display-message -p '#S'"
    tmux_session_name = handle:read "*l" or ""
    handle:close()
    -- lists whether the pane is zoomed or not
    handle = io.popen "tmux list-panes -F '#F'"
    local zoom_info = handle:read "*a" or ""
    handle:close()
    -- if there is a "Z" in the list then the pane is zoomed
    tmux_zoomed = zoom_info:find "Z" ~= nil
end

-- Function to delete all buffers listed in the `:buffers` vim command (not all the buffers listed in `:buffers!`)
-- TODO: change all functions to this format
-- vim.api.nvim_create_user_command() format instead of global function see "https://github.com/nanotee/nvim-lua-guide?tab=readme-ov-file#defining-user-commands"
vim.api.nvim_create_user_command('DeleteListedBuffers', function()
    local notify = require("notify")
    local current_buf = vim.api.nvim_get_current_buf()
    local buffers = vim.fn.getbufinfo({buflisted = 1})
    local success = true
    local count = 0
    for _, buf in ipairs(buffers) do
        if buf.bufnr ~= current_buf then
            local modified = vim.api.nvim_buf_get_option(buf.bufnr, 'modified')
            if modified then
                local path = vim.api.nvim_buf_get_name(buf.bufnr)
                local filename = vim.fn.expand("#" .. path .. ":h")
                notify(filename .. " has unsaved changes. Not deleting.", "warn", {
                    title = "buffers"
                })
                success = false
            else
                vim.api.nvim_buf_delete(buf.bufnr, {})
                count = count + 1
            end
        end
    end
    if success == true and count > 0 then
        notify("Successfully deleted " .. count .. " hanging buffers", "info", {
            title = "buffers"
        })
    end
end, {})

-------------------------------------- NULL-LS -------------------------------------

-- Custom command to stop the null-ls LSP client
-- Keybind <leader>lnd
-- File: none-ls.lua
vim.api.nvim_create_user_command("NullLsStop", function()
    local null_ls_client
    -- search for null-ls client in the active clients
    for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.name == "null-ls" then
            null_ls_client = client
            break
        end
    end
    if null_ls_client then
        -- we want to stop the LSP null-ls client and disable its messages/functionality
        vim.lsp.stop_client(null_ls_client.id)
        require("null-ls").disable({})
    end
end, {})

-------------------------------------- CHEZMOI -------------------------------------

--- Custom command to run `chezmoi re-add %`
vim.api.nvim_create_user_command("WC", function()
    local chezmoi_list = vim.fn.system("chezmoi list")
    local user_home = vim.fn.system("echo $HOME" .. "/")
    local filepath = vim.fn.expand("%") -- Get the full path of the current file

    vim.notify("Running `chezmoi re-add`...")
    vim.cmd("write")
    vim.fn.system({"chezmoi", "re-add", filepath})
end, {})

local M = {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- see cmp.lua for config
    }
}

function M.init()
    -- Nerd Font support --
    vim.g.db_ui_use_nerd_fonts = 1

    -- DB initialization (.env file contains these variables -> sourced with direnv) --
    vim.g.db_ui_env_variable_url = 'DATABASE_URL' -- make sure we have db url prefix (e.g: sqlite:///)
    vim.g.db_ui_env_variable_name = 'DATABASE_NAME'

    -- Notification settings
    vim.g.db_ui_force_echo_notifications = 1
    vim.g.db_ui_use_nvim_notify = 1

    -- Disable execute on save
    vim.g.db_ui_execute_on_save = 0

    -- Auto-execution of table helpers
    vim.g.db_ui_auto_execute_table_helpers = 1

    -- Disable help menu
    vim.g.db_ui_show_help = 0

    -- Drawer width
    vim.g.db_ui_winwidth = 60

    -- Mappings --
    vim.cmd [[
        autocmd FileType dbui nmap <buffer> f <Plug>(DBUI_SelectLine)
        autocmd FileType dbui nmap <buffer> <C-v> <Plug>(DBUI_SelectLineVsplit)
        autocmd FileType sql nmap <buffer> <C-w> <Plug>(DBUI_SaveQuery)
        autocmd FileType sql nmap <buffer> <C-e> <Plug>(DBUI_ExecuteQuery)
    ]]
end

return M

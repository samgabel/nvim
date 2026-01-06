return {



-- ========================================================================================
-- CHEZMOI -> HIGHLIGHT/PICKER-LIST
-- ========================================================================================
    {
        {
            "alker0/chezmoi.vim",
            init = function()
                vim.g["chezmoi#use_tmp_buffer"] = 1
                vim.g["chezmoi#source_dir_path"] = vim.env.HOME .. "/.local/share/chezmoi"
            end,
        },
        {
            "xvzc/chezmoi.nvim",
            cmd = { "ChezmoiEdit", "ChezmoiList" },
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function ()
                -- TODO: flesh out once new config in XDG_CONFIG_HOME
                require("chezmoi").setup({})
            end
        }
    },



-- ========================================================================================
-- YAML -> SCHEMASTORE/HELM
-- ========================================================================================
    {
        {
            "b0o/schemastore.nvim",
            ft = "yaml",
        },
        {
            "towolf/vim-helm",
            ft = "helm"
        }
    }


}

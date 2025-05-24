---@diagnostic disable: missing-fields

local M = {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = "VeryLazy",
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {},
}

function M.config()
    local wk = require "which-key"
    wk.register {
        ["<leader>on"] = { "<cmd>ObsidianNew<cr>", "New File" },
        ["<leader>oo"] = { "<cmd>ObsidianOpen<cr>", "Open" },
        ["<leader>of"] = { "<cmd>ObsidianQuickSwitch<cr>", "Find File" },
        ["<leader>os"] = { "<cmd>ObsidianSearch<cr>", "Search Text" },
        ["<leader>ot"] = { "<cmd>ObsidianTemplate<cr>", "Insert Template" },
        ["<leader>op"] = { "<cmd>ObsidianPasteImg<cr>", "Paste Img" },
        ["<leader>olf"] = { "<cmd>ObsidianFollowLink<cr>", "To Link" },
        ["<leader>olb"] = { "<cmd>ObsidianBacklinks<cr>", "Back Link" },
    }

    vim.api.nvim_set_hl(0, "@markup.italic", { fg = "#d9b6e3", italic = true })

    -- https://github.com/epwalsh/obsidian.nvim
    require("obsidian").setup {

        workspaces = {
            {
                name = "docs",
                path = "~/Documents/docs",
            },
        },

        -- where notes are first created using <leader>on
        notes_subdir = "ZETTELKASTEN/300-Fleeting",
        new_notes_location = "notes_subdir",

        --> -------------------------- Hacked the src code in obsidian/util.lua -------------------------- <--
        -- This will change spaces in headers to "%20" instead of "-"
        -- This allows for greatest compatibility between nvim, obsidian, github, markdown renderers
        -- TODO: obsidian.nvim custom links functionality:
        -- obsidian.nvim nvim-cmp search by header,
        -- specify custom whitespace anchoring ("-", or "%20"),
        -- absolute links from vault root


        -- --- Standardize a header anchor link.
        -- ---
        -- ---@param anchor string
        -- ---
        -- ---@return string
        -- util.standardize_anchor = function(anchor)
        -- -- Lowercase everything.
        -- anchor = string.lower(anchor)
        -- -- Replace whitespace with "%20".
        -- anchor = string.gsub(anchor, "%s", "%%20")
        -- -- Removes whitespaces, commas, exclamation marks, parentheses, etc
        -- anchor = string.gsub(anchor, "[^#%w%%20_-]", "")
        --     return anchor
        -- end


        -- Also this commit below is the commit that allows for searching through headers
        -- version: 3.7.6 / tag: v3.7.6 / branch: main / commit: d70f328
        -- "obsidian.nvim": { "branch": "main", "commit": "d70f3289399c25153b7f503b838afbf981124a37" },
        --> ---------------------------------------------------------------------------------------------- <--

        -- disable automatic "Properties" section
        disable_frontmatter = true,

        -- use templates instead
        templates = {
            subdir = "ZETTELKASTEN/assets/templates",
        },

        -- enable external links in buffer
        follow_url_func = function(url)
            vim.fn.jobstart { "open", url }
        end,

        -- brings obsidian app to foreground when running :ObsidianOpen
        open_app_foreground = true,

        -- disables "Create a New Note" from :ObsidianSearch use :ObsidianNewNote instead
        finder_mappings = {},

        -- stores images in this dir using :ObsidianPasteImage
        attachments = {
            img_folder = "ZETTELKASTEN/assets/imgs",
        },
    }
end

return M

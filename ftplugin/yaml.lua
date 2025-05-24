-- indent-line support
local hooks = require("ibl.hooks")
hooks.register(hooks.type.ACTIVE, function()
    return vim.opt_local.filetype:get() == "yaml"
end)

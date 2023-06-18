local init = require "user.plugins.init"
local null_ls = require "user.plugins.null_ls"

-- Configure plugins
local plugins = {
    init = init,
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = null_ls,
    treesitter = { ensure_installed = "all" },
    -- use mason-lspconfig to configure LSP installations
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-lspconfig"] = { ensure_installed = { "sumneko_lua" } },
    ["mason-tool-installer"] = { ensure_installed = { "prettier", "stylua" } },
    packer = { compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua" },
    session_manager = { autosave_last_session = true },
    toggleterm = {
        --open_mapping = [[<c-t>]]
        --[[ direction = "horizontal", ]]
    },
}

return plugins

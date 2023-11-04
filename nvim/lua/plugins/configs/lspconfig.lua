local cwd = vim.loop.cwd()
local lspconfig = require "lspconfig"
local on_attach = require('utils').LSP_on_attach
local capabilities = require('utils').LSP_capabilities()
local dedault_configures = { on_attach = on_attach, capabilities = capabilities }

-- diagnostics
for name, icon in pairs(require("icons").diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

local servers = {
  html = {},
  cssls = {},
  clangd = {},
  marksman = {},
  spectral = {},
  gopls = {},
  emmet_ls = {},
  solargraph = { only = { "/Users/lixibox/work/lixibox" } },
  ruby_ls = { ignore = { "/Users/lixibox/work/lixibox" } },
  tsserver = { others = { init_options = { preferences = { quotePreference = "single" } } } },
  lua_ls = { others = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } } },
}

for lsp, config in pairs(servers) do
  if config.ignore then
    local ignore = config.ignore
    if type(ignore) == "string" then ignore = { ignore } end

    for _, path in ipairs(ignore) do
      if cwd == path then
        goto continue
      end
    end
  end

  if config.only then
    local only = config.only
    if type(only) == "string" then only = { only } end

    local found = false
    for _, path in ipairs(only) do
      if cwd == path then
        found = true
        break
      end
    end
    if not found then goto continue end
  end

  local configure = dedault_configures
  if config.others then configure = vim.tbl_extend("keep", configure, config.others) end

  lspconfig[lsp].setup(configure)
  ::continue::
end

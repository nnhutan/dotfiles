return function()
  local lspconfig = require "lspconfig"
  local servers = require "servers"
  local on_attach = require('utils').LSP_on_attach
  local capabilities = require('utils').LSP_capabilities()
  local default_configures = { on_attach = on_attach, capabilities = capabilities }

  -- diagnostics
  for name, icon in pairs(require("icons").diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = false,
  })

  for server, configures in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend("force", default_configures, configures.configs or {}))
  end
end

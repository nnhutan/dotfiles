local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"

local on_attach_v2 = function(client, bufnr)
  require("plugins.configs.lspconfig").on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "CursorHold" }, {
    buffer = bufnr,

    callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        if err then
          return
        end

        if not result then
          return
        end

        vim.lsp.diagnostic.on_publish_diagnostics(
          nil,
          vim.tbl_extend("keep", params, { diagnostics = result.items }),
          { client_id = client.id }
        )
      end)
    end,
  })
end

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local custom_servers = { "solargraph", "marksman" }

for _, lsp in ipairs(custom_servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach_v2,
    capabilities = capabilities,
  }
end

lspconfig.yamlls.setup {
  on_attach = on_attach_v2,
  capabilities = capabilities,
  filetypes = { "yaml", "yml", "yaml.docker-compose" },
}

lspconfig.tsserver.setup {
  on_attach = on_attach_v2,
  capabilities = capabilities,
  init_options = {
    preferences = {
      quotePreference = "single",
    },
  },
}

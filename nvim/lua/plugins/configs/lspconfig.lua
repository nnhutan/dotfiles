local map = vim.keymap.set
-- -- Use LspAttach autocommand to only map the following keys
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--   callback = function(ev)
--     -- Enable completion triggered by <c-x><c-o>
--   end,
-- })


local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true

  local opts = { buffer = bufnr }
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  map("n", "<space>D", vim.lsp.buf.type_definition, opts)
  map("n", "<space>lr", vim.lsp.buf.rename, opts)
  map({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  -- map("n", "<space>f", function()
  --   vim.lsp.buf.format { async = true }
  -- end, opts)
  if not client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end

  if client.supports_method("textDocument/inlayHint") then
    inlay_hint(bufnr, true)
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "CursorHold", "InsertLeave", "TextChanged" }, {
    buffer = bufnr,

    callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        if err then return end
        if not result then return end

        vim.lsp.diagnostic.on_publish_diagnostics(nil, vim.tbl_extend("keep", params, { diagnostics = result.items }),
          { client_id = client.id })
      end)
    end,
  })
end

-- diagnostics
for name, icon in pairs(require("icons").diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_nvim_lsp.default_capabilities() or {}
)

local have_mason, mlsp = pcall(require, "mason-lspconfig")
local all_mslp_servers = {}
if have_mason then
  all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
end

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
-- Setup language servers.
local lspconfig = require "lspconfig"

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
}


local cwd = vim.loop.cwd()
local dedault_configures = { on_attach = on_attach, capabilities = capabilities }
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
}


local ensure_installed = {}
for lsp, config in pairs(servers) do
  if vim.tbl_contains(all_mslp_servers, lsp) then
    ensure_installed[#ensure_installed + 1] = lsp
    goto continue
  end
  if config.ignore then
    local ignore = config.ignore

    if type(ignore) == "string" then
      ignore = { ignore }
    end

    for _, path in ipairs(ignore) do
      if cwd == path then
        goto continue
      end
    end
  end

  if config.only then
    local only = config.only

    if type(only) == "string" then
      only = { only }
    end

    local found = false
    for _, path in ipairs(only) do
      if cwd == path then
        found = true
        break
      end
    end
    if not found then
      goto continue
    end
  end

  local configure = dedault_configures
  if config.others then
    configure = vim.tbl_extend("keep", configure, config.others)
  end

  lspconfig[lsp].setup(configure)
  ::continue::
end

local function setup(server)
  lspconfig[server].setup(dedault_configures)
end

if have_mason then
  mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
end

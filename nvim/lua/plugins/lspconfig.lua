local icons = require('cores.icons').diagnostics

local get_config = function(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

local disable = function(server, cond)
  local util = require("lspconfig.util")
  local def = get_config(server)
  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config,
    function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end)
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim",  opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
    require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {}
    )

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
    local opts = require "servers"


    vim.diagnostic.config({
      virtual_text = false,
      -- virtual_text = {
      --   spacing = 4,
      --   source = "if_many",
      --   prefix = function(diagnostic)
      --     for d, icon in pairs(icons) do
      --       if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
      --         return icon
      --       end
      --     end
      --   end,
      -- },
      severity_sort = true,
      inlay_hints = { enabled = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
      underline = false,
      update_in_insert = false,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf ---@type number
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local map = vim.keymap.set
        if not client.supports_method("textDocument/semanticTokens") then client.server_capabilities.semanticTokensProvider = nil end
        if client and client.supports_method("textDocument/inlayHint") then
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end

        local keymap_opts = { buffer = bufnr }
        map("n", "[d", vim.diagnostic.goto_prev)
        map("n", "]d", vim.diagnostic.goto_next)
        map("n", "gD", vim.lsp.buf.declaration, keymap_opts)
        map("n", "gd", vim.lsp.buf.definition, keymap_opts)
        map("n", "K", vim.lsp.buf.hover, keymap_opts)
        map("n", "gi", vim.lsp.buf.implementation, keymap_opts)
        map("n", "<C-k>", vim.lsp.buf.signature_help, keymap_opts)
        map("n", "<space>D", vim.lsp.buf.type_definition, keymap_opts)
        map("n", "<space>lr", vim.lsp.buf.rename, keymap_opts)
        map({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, keymap_opts)
        map("n", "gr", vim.lsp.buf.references, keymap_opts)

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

        vim.cmd([[ hi! link FloatBorder TelescopePreviewBorder ]])
      end,
    })

    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    end

    local servers = opts.servers
    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    local ensure_installed = {}
    for server, server_opts in pairs(servers) do
      if require("neoconf").get("lspconfig." .. server .. ".disable") then
        return
      end
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end
    end

    if have_mason then
      mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
    end

    if get_config("denols") and get_config("tsserver") then
      local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      disable("tsserver", is_deno)
      disable("denols", function(root_dir)
        return not is_deno(root_dir)
      end)
    end
  end
}

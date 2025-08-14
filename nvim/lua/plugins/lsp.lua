---@diagnostic disable: no-unknown
local icons = require('cores.icons').diagnostics

return {
  { 'williamboman/mason.nvim' },
  { "williamboman/mason-lspconfig.nvim" },
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()
      --
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr, noremap = true })

        if client.name == "eslint" then
          client.server_capabilities.documentFormattingProvider = true
        elseif client.name == "ts_ls" then
          client.server_capabilities.documentFormattingProvider = false
        end

        local map = vim.keymap.set
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, noremap = true, desc = 'Go to definition' })
        map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, noremap = true, desc = 'References' })
        map("n", "<leader>k>", vim.lsp.buf.signature_help, { buffer = bufnr, noremap = true, desc = 'Signature help' })
        map("n", "<space>lr", vim.lsp.buf.rename, { buffer = bufnr, noremap = true, desc = 'Rename' })
        map({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, desc = 'Code actions' })
        map("n", "<leader>li",
          function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
          { buffer = bufnr, noremap = true, desc = 'Inlay hints' })
        map("n", "gv", function()
          vim.lsp.buf.definition()
          vim.cmd("vsplit")
        end, { buffer = bufnr, noremap = true, desc = 'Go to definition in vertical split' })
        map("n", "gh", function()
          vim.lsp.buf.definition()
          vim.cmd("split")
        end, { buffer = bufnr, noremap = true, desc = 'Go to definition in horizontal split' })
        -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "CursorHold", "InsertLeave", "TextChanged" }, {
        --   buffer = bufnr,
        --   callback = function()
        --     local params = vim.lsp.util.make_text_document_params(bufnr)
        --
        --     client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        --       if err then return end
        --       if not result then return end
        --
        --       vim.lsp.diagnostic.on_publish_diagnostics(nil,
        --         vim.tbl_extend("keep", params, { diagnostics = result.items }),
        --         { client_id = client.id })
        --     end)
        -- end,
        -- })
      end)

      lsp_zero.set_sign_icons({
        error = icons.Error,
        warn = icons.Warn,
        hint = icons.Hint,
        info = icons.Info,
      })

      vim.diagnostic.config({
        underline = false,
        update_in_insert = false,
        virtual_text = false,
      })

      local lspconfig = require('lspconfig')
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        require("cmp_nvim_lsp").default_capabilities(),
        vim.lsp.protocol.make_client_capabilities()
      )
      local handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true
          }
        )
      }
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          "html",
          "cssls",
          "clangd",
          "yamlls",
          "emmet_ls",
          "jsonls",
          "eslint",
          "ruby_lsp",
          "ts_ls",
        },
        handlers = {
          lsp_zero.default_setup,
          -- function(server_name)
          --   require('lspconfig')[server_name].setup({
          --     capabilities = capabilities,
          --   })
          -- end,
          -- solargraph = function()
          --   require('lspconfig').solargraph.setup({
          --     cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", 'stdio' },
          --     -- cmd = { "solargraph", "stdio" },
          --     root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
          --     settings = {
          --       solargraph = {
          --         autoformat = true,
          --         completion = true,
          --         diagnostic = true,
          --         folding = true,
          --         references = true,
          --         rename = true,
          --         symbols = true
          --       }
          --     },
          --     capabilities = vim.tbl_deep_extend(
          --       "force",
          --       {},
          --       require("cmp_nvim_lsp").default_capabilities(),
          --       vim.lsp.protocol.make_client_capabilities()
          --     ),
          --     -- handlers = handlers,
          --   })
          -- end,
          -- ruby_lsp = function()
          --   require('lspconfig').ruby_lsp.setup({
          --     cmd_env = { BUNDLE_GEMFILE = vim.fn.getenv('GLOBAL_GEMFILE') },
          --     cmd = {
          --       "rbenv local (cat .ruby-version)", "ruby-lsp"
          --     }
          --   })
          -- end,
          ts_ls = function()
            require('lspconfig').ts_ls.setup({
              capabilities = capabilities,
              init_options = {
                preferences = {
                  disableSuggestions = false,
                  quotePreference = "single",
                  includeInlayEnumMemberValueHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  formatting = false
                },
              }
            })
          end
        }
      })

      -- local configs = require 'lspconfig.configs'
      -- if not configs.fuzzy_ls then
      --   configs.fuzzy_ls = {
      --     default_config = {
      --       cmd = { 'fuzzy' },
      --       filetypes = { 'ruby' },
      --       root_dir = function(fname)
      --         return lspconfig.util.find_git_ancestor(fname)
      --       end,
      --       settings = {},
      --       init_options = {
      --         allocationType = "ram",
      --         indexGems = true,
      --         reportDiagnostics = true
      --       },
      --     },
      --   }
      -- end
    end
  } }

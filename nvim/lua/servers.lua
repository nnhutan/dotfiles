local util = require 'lspconfig.util'
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end
return
{
  servers = {
    html = { mason = false, },
    cssls = { mason = false, },
    clangd = { mason = false, },
    yamlls = { mason = false },
    emmet_ls = { mason = false, },
    jsonls = { mason = false },
    eslint = { mason = false, },
    solargraph = {
      mason = true,
      init_options = {
        cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", 'stdio' },
        -- formatting = false,
        settings = {
          -- solargraph = {
          --   format = false,
          --   autoformat = false,
          --   formatting = false,
          --   completion = true,
          --   diagnostic = false,
          --   folding = true,
          --   references = true,
          --   rename = true,
          --   symbols = true,
          --   diagnostics = false,
          --   hover = true,
          --   definitions = true,
          -- }
        }
      }
    },
    -- sorbet = { mason = false, },
    -- ruby_lsp = {
    --   mason = true,
    --   init_options = {
    --     cmd = { os.getenv("HOME") .. "/.rbenv/shims/ruby-lsp" },
    --     enableExperimentalFeatures = true,
    --     featuresConfiguration = { inlayHint = { enableAll = true }, },
    --     enabledFeatures = {
    --       'codeActions',
    --       'diagnostics',
    --       'documentHighlights',
    --       'documentLink',
    --       'documentSymbols',
    --       'foldingRanges',
    --       'formatting',
    --       'hover',
    --       'inlayHint',
    --       'onTypeFormatting',
    --       'selectionRanges',
    --       'semanticHighlighting',
    --       'completion',
    --       'codeLens',
    --       'definition',
    --       'workspaceSymbol'
    --     },
    --   }
    -- },
    ts_ls = {
      mason = false,
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
        -- commands = {
        --   OrganizeImports = {
        --     organize_imports,
        --     description = "Organize Imports"
        --   }
        -- }
      }
    },
    lua_ls = {
      mason = false,
      single_file_support = true,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Both",
          },
          misc = {
            parameters = {
              -- "--log-level=trace",
            },
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = "Disable",
            semicolon = "Disable",
            arrayIndex = "Disable",
          },
          doc = {
            privateName = { "^_" },
          },
          type = {
            castNumberToInteger = true,
          },
          diagnostics = {
            globals = { 'vim' },
            disable = { "incomplete-signature-doc", "trailing-space" },
            -- enable = false,
            groupSeverity = {
              strong = "Warning",
              strict = "Warning",
            },
            groupFileStatus = {
              ["ambiguity"] = "Opened",
              ["await"] = "Opened",
              ["codestyle"] = "None",
              ["duplicate"] = "Opened",
              ["global"] = "Opened",
              ["luadoc"] = "Opened",
              ["redefined"] = "Opened",
              ["strict"] = "Opened",
              ["strong"] = "Opened",
              ["type-check"] = "Opened",
              ["unbalanced"] = "Opened",
              ["unused"] = "Opened",
            },
            unusedLocalExclude = { "_*" },
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              continuation_indent_size = "2",
              max_line_length = "240",
            },
          },
        },
      },
    },
  },
  setup = {},
}

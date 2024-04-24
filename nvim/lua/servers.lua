return
{
  servers = {
    html = {},
    cssls = {},
    clangd = {},
    marksman = {},
    yamlls = {},
    emmet_ls = {},
    jsonls = {},
    solargraph = {
      mason = false,
    },
    sorbet = {
      mason = false,
    },
    ruby_lsp = {
      mason = false,
      init_options = {
        enableExperimentalFeatures = true,
        featuresConfiguration = {
          inlayHint = {
            enableAll = true
          }
        },
        enabledFeatures = {
          "codeActions",
          "diagnostics",
          "documentHighlights",
          "documentLink",
          "documentSymbols",
          "foldingRanges",
          "formatting",
          "hover",
          "inlayHint",
          -- "onTypeFormatting",
          "selectionRanges",
          "semanticHighlighting",
          "completion",
          "codeLens",
          "definition",
          "workspaceSymbol"
        }
      }
    },
    tsserver = { init_options = { preferences = { quotePreference = "single" } } },
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
  setup = {
  },
}

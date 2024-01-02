local available = function(conditions)
  local current = vim.fn.getcwd()
  local ignores = conditions.ignore or {}
  local onlys = conditions.only or { current }

  return not vim.tbl_contains(ignores, current) and vim.tbl_contains(onlys, current)
end

return {
  ["html"] = {},
  ["cssls"] = {},
  ["clangd"] = {},
  ["marksman"] = {},
  ["yamlls"] = {},
  ["gopls"] = {},
  ["emmet_ls"] = {},
  ["jsonls"] = {},
  ["solargraph"] = {},
  ["pasls"] = {},
  ["omnisharp"] = {
    configs = {
      cmd = { 'dotnet', '/Users/lixibox/Desktop/omnisharp-osx-x64-net6.0/OmniSharp.dll', '--languageserver', '--hostPID',
        tostring(vim.fn.getpid()) }
    }
  },
  -- ["solargraph"] = { unattachable = not available({ only = { "/Users/lixibox/work/lixibox" }, ignore = nil }), },
  -- ["ruby_ls"] = { unattachable = not available({ ignore = { "/Users/lixibox/work/lixibox" }, only = nil }),
  --   -- configs = {
  --   --   init_options = {
  --   --     enabledFeatures = {
  --   --       "documentHighlights",
  --   --       "documentLink",
  --   --       "documentSymbols",
  --   --       "hover",
  --   --       "inlayHint",
  --   --       "foldingRanges",
  --   --       "selectionRanges",
  --   --       "codeLens",
  --   --       "completion",
  --   --       -- "semanticHighlighting",
  --   --       "formatting",
  --   --       "codeActions",
  --   --       "diagnostics"
  --   --     }
  --   --   }
  --
  --   -- }
  -- },
  ["tsserver"] = { configs = { init_options = { preferences = { quotePreference = "single" } } } },
  ["lua_ls"] = { configs = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } } },
}

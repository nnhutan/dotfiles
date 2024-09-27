return {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  config = function()
    local null_ls = require("null-ls")
    -- local haml_formatter = {
    --   method = null_ls.methods.FORMATTING,
    --   filetypes = { "haml" },
    --   generator = null_ls.formatter({
    --     command = "sh",
    --     -- args = { "-c", "haml-lint -a $0", '$FILENAME' },
    --     args = {
    --       "haml-lint",
    --       "-a",
    --       "$FILENAME",
    --     },
    --     to_stdin = false
    --     -- from_stderr = true,
    --   }),
    -- }
    --
    -- null_ls.register(haml_formatter)

    -- null_ls.setup({
    --   sources = {
    --     null_ls.builtins.diagnostics.haml_lint.with {
    --       env = {
    --         RUBYOPT = "-W0",
    --       },
    --       diagnostic_config = {
    --         update_in_insert = false,
    --       },
    --       method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    --     },
    --   },
    -- })
  end,
}

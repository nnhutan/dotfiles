return {
  "nvimtools/none-ls.nvim",
  event = "BufReadPre",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.haml_lint.with {
          env = {
            RUBYOPT = "-W0",
          },
        },
      },
    })
  end,
}

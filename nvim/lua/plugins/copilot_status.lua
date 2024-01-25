return {
  "jonahgoldwastaken/copilot-status.nvim",
  dependencies = { "zbirenbaum/copilot.lua" },
  event = "BufReadPost",
  config =
      function()
        require("copilot_status").setup({
          icons = {
            idle = " ",
            offline = " ",
            warning = " ",
            error = " ",
            loading = " ",
          },
          debug = false,
        })
      end
}

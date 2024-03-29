return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config =
      function()
        require("ibl").setup({
          indent = {
            char = "│",
            tab_char = "│",
          },
          scope = { enabled = false },
          exclude = {
            filetypes = {
              "help",
              "terminal",
              "lazy",
              "lspinfo",
              "TelescopePrompt",
              "TelescopeResults",
              "mason",
              "nvdash",
              "nvcheatsheet",
              "neo-tree",
              "notify",
              "dashboard",
              "noice",
              "",
            }
          }
        })
      end
}

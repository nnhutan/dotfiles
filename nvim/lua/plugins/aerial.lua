return {
  "stevearc/aerial.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
    attach_mode = "global",
    close_behavior = "global",
    icons = require('cores.icons').kinds,
    guides = {
      mid_item = "├ ",
      last_item = "└ ",
      nested_top = "│ ",
      whitespace = "  ",
    },
    filter_kind = false,
    lazy_load = true
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
}

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  cmd =
  "Trouble",
  config = function()
    require("trouble").setup()
  end,
}

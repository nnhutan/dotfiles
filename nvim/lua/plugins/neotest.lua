return
{
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "olimorris/neotest-rspec",
    "nvim-lua/plenary.nvim",
    -- "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config =
      function()
        require("neotest").setup({
          adapters = {
            require("neotest-rspec")
          },
        })
      end
}

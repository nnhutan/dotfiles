return {
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    enabled = false,
    config = function()
      require('Comment').setup {
        pre_hook = function()
          return vim.bo.commentstring
        end,
      }
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    enabled = false,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  }
}

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config =
      function()
        require("gitsigns").setup({
          signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "󰍵" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "│" },
          },
          current_line_blame = true
        })
        local map = vim.keymap.set
        map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
        map("n", "<leader>gd", function() require("gitsigns").diffthis() end, { desc = "Git diff" })
        map("n", "<leader>gl", function() package.loaded.gitsigns.blame_line() end, { desc = "Blame line" })
      end
}

return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", "y", "\\" },
  cmd = "WhichKey",
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").add({
      { "<leader>S", group = "Session" },
      { "<leader>b", group = "Buffer" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>k", group = "GPT" },
      { "<leader>l", group = "LSP" },
      { "<leader>o", group = "Focus file" },
      { "<leader>p", group = "Others" },
      { "<leader>t", group = "Test" },
      { "<leader>a", group = "Copilot" },
    })
  end
}

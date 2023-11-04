return function(_, opts)
  require("which-key").setup(opts)
  

  require("which-key").register({
    b = { name = "Buffer" },
    g = { name = "Git" },
    f = { name = "Find" },
    l = { name = "LSP" },
    T = { name = "Test" },
    p = { name = "Others" },
    S = { name = "Session" },
    k = { name = "GPT" },
  }, { prefix = "<leader>" })
end


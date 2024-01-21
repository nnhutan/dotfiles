return function(_, opts)
  require("which-key").setup(opts)


  require("which-key").register({
    b = { name = "Buffer" },
    g = { name = "Git" },
    f = { name = "Find" },
    l = { name = "LSP" },
    t = { name = "Test" },
    p = { name = "Others" },
    S = { name = "Session" },
    k = { name = "GPT" },
    h = { name = "Harpoon" },
    e = { name = "Explorer" },
    o = { name = "Focus file" },
    [" "] = { name = "Projects" },
  }, { prefix = "<leader>" })
end

return function()
  require("neotest").setup({
    adapters = {
      require("neotest-rspec")
    },
  })
end

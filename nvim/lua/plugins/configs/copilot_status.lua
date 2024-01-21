return function()
  require("copilot_status").setup({
    icons = {
      idle = " ",
      offline = " ",
      warning = " ",
      error = " ",
      loading = " ",
    },
    debug = false,
  })
end

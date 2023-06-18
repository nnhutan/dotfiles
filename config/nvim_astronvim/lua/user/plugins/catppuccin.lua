return function()
  require("catppuccin").setup {
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      functions = { "italic" },
      keywords = { "italic", "bold" },
      strings = { "italic" },
    },
  }
end

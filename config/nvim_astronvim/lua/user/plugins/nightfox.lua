return function()
  require("nightfox").setup {
    options = {
      styles = {
        comments = "italic",
        keywords = "italic,bold",
        --[[ types = "italic,bold", ]]
        functions = "italic",
        strings = "italic",
        --[[ variables = "italic", ]]
      },
    },
  }
end

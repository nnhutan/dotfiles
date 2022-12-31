return function()
  require("material").setup {
    italics = {
      comments = true, -- Enable italic comments
      keywords = true, -- Enable italic keywords
      functions = true, -- Enable italic functions
      strings = true, -- Enable italic strings
      variables = true, -- Enable italic variables
    },
    lualine_style = "stealth", -- default or stealth
  }
end

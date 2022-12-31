local config = {
  cmp = require "user.cmp",
  lsp = require "user.lsp",
  header = require "user.header",
  updater = require "user.updater",
  options = require "user.options",
  plugins = require "user.plugins",
  luasnip = require "user.luasnip_conf",
  mappings = require "user.mappings",
  colorscheme = require "user.colorscheme",
  diagnostics = require "user.diagnostics",
  default_theme = require "user.default_theme",
  ["which-key"] = require "user.which_key",
  polish = require "user.polish",
}

return config

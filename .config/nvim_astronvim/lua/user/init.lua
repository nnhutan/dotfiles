local config = {
  cmp = require("user.cmp"),
  lsp = require("user.lsp"),
  header = require("user.header"),
  updater = require("user.updater"),
  options = require("user.options"),
  plugins = require("user.plugins"),
  mappings = require("user.mappings"),
  luasnip = require("user.luasnip_conf"),
  highlights = require("user.highlights"),
  colorscheme = require("user.colorscheme"),
  diagnostics = require("user.diagnostics"),
  ["which-key"] = require("user.which_key"),
  default_theme = require("user.default_theme"),
  polish = require("user.polish"),
}

return config

return function()
  local mocha = require("catppuccin.palettes").get_palette "frappe"
  require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get({
      styles = { "italic", "bold" },
      custom = {
        frappe = {
          background = { bg = mocha.crust },
          tab_separator = { fg = mocha.crust },
          separator = { bg = mocha.crust },
          separator_selected = { bg = mocha.base, },
          tab_separator_selected = { bg = mocha.base, },
          close_button = { bg = mocha.crust },
        },
      },
    }),
    options = {
      themable = true,
      close_command = function(n) require("mini.bufremove").delete(n, false) end,
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
      offsets = {
        { filetype = "NvimTree", highlight = "NvimTreeNormal" },
      },
    },
  }
end

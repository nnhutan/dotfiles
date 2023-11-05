return function()
  local C = require("catppuccin.palettes").get_palette "frappe"
  local inactive_bg = C.crust

  require("bufferline").setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get({
      styles = { "italic", "bold" },
      custom = {
        frappe = {
          -- buffers
          background = { bg = inactive_bg },
          buffer_visible = { fg = C.surface1, bg = inactive_bg },
          -- Duplicate
          duplicate_visible = { fg = C.surface1, bg = inactive_bg },
          duplicate = { fg = C.surface1, bg = inactive_bg },
          -- tabs
          tab = { fg = C.surface1, bg = inactive_bg },
          tab_separator = { bg = inactive_bg },

          tab_close = { fg = C.red, bg = inactive_bg },
          -- separators
          separator = { bg = inactive_bg },
          separator_visible = { bg = inactive_bg },
          -- close buttons
          close_button = { fg = C.surface1, bg = inactive_bg },
          close_button_visible = { fg = C.surface1, bg = inactive_bg },
          -- Empty fill
          -- Numbers
          numbers = { fg = C.subtext0, bg = inactive_bg },
          numbers_visible = { fg = C.subtext0, bg = inactive_bg },
          -- Errors
          error = { fg = C.red, bg = inactive_bg },
          error_visible = { fg = C.red, bg = inactive_bg },
          error_diagnostic = { fg = C.red, bg = inactive_bg },
          error_diagnostic_visible = { fg = C.red, bg = inactive_bg },
          -- Warnings
          warning = { fg = C.yellow, bg = inactive_bg },
          warning_visible = { fg = C.yellow, bg = inactive_bg },
          warning_diagnostic = { fg = C.yellow, bg = inactive_bg },
          warning_diagnostic_visible = { fg = C.yellow, bg = inactive_bg },
          -- Infos
          info = { fg = C.sky, bg = inactive_bg },
          info_visible = { fg = C.sky, bg = inactive_bg },
          info_diagnostic = { fg = C.sky, bg = inactive_bg },
          info_diagnostic_visible = { fg = C.sky, bg = inactive_bg },
          -- Hint
          hint = { fg = C.teal, bg = inactive_bg },
          hint_visible = { fg = C.teal, bg = inactive_bg },
          hint_diagnostic = { fg = C.teal, bg = inactive_bg },
          hint_diagnostic_visible = { fg = C.teal, bg = inactive_bg },
          -- Diagnostics
          diagnostic = { fg = C.subtext0, bg = inactive_bg },
          diagnostic_visible = { fg = C.subtext0, bg = inactive_bg },
          -- Modified
          modified = { fg = C.peach, bg = inactive_bg },
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

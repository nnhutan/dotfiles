return {
  "akinsho/bufferline.nvim",
  event = "BufReadPre",
  config =
      function()
        local C = require("catppuccin.palettes").get_palette "frappe"
        local L = require("catppuccin.palettes").get_palette "latte"
        local inactive_bg = C.crust

        vim.cmd([[
    function! ToggleTheme(a, b, c, d)
      lua require("utils").toggle_theme()
    endfunction
  ]])

        vim.cmd([[
    function! CloseAllBuffers(a, b, c, d)
      lua require("utils").close_all_buffers()
    endfunction
  ]])


        require("bufferline").setup {
          highlights = require("catppuccin.groups.integrations.bufferline").get({
            styles = { 'light' },
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
                tab_selected = {
                  fg = C.text
                },


                tab_close = { fg = C.surface1, bg = C.pink },
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
            buffer_close_icon = "󰅖",
            close_icon = "󰅖",
            show_close_icon = false,
            show_buffer_close_icons = true,
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            offsets = {
              { filetype = "NvimTree", highlight = "NvimTreeNormal" },
            },
            custom_areas = {
              right = function()
                resutls = {}
                local flvr = require("catppuccin").flavour or vim.g.catppuccin_flavour or "frappe"
                if flvr ~= "latte" then
                  table.insert(resutls, { text = "%@ToggleTheme@" .. "   ", fg = C.red, bg = C.surface1 })
                  table.insert(resutls, { text = "%@CloseAllBuffers@  ", fg = C.surface1, bg = C.red })
                else
                  table.insert(resutls, { text = "%@ToggleTheme@" .. "  ", fg = L.blue, bg = L.surface0 })
                  table.insert(resutls, { text = "%@CloseAllBuffers@  ", fg = L.surface1, bg = L.red })
                end
                return resutls
              end,
            }

          },

        }
      end
}

return {
  "akinsho/bufferline.nvim",
  enabled = false,
  event = "BufReadPre",
  config = function()
    vim.cmd([[ function! ToggleTheme(a, b, c, d)
                  lua require("utils").toggle_theme()
                endfunction

                function! CloseAllBuffers(a, b, c, d)
                            lua require("utils").close_all_buffers()
                          endfunction ]])


    require("bufferline").setup {
      highlights = require("catppuccin.groups.integrations.bufferline").get({ styles = { 'light' }, }),
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
            local results = {}
            local flvr = require("catppuccin").flavour or vim.g.catppuccin_flavour or "frappe"
            local C = require("catppuccin.palettes").get_palette()

            if flvr ~= "latte" then
              table.insert(results, { text = "%@ToggleTheme@" .. "   ", fg = C.red, bg = C.mantle })
            else
              table.insert(results, { text = "%@ToggleTheme@" .. "  ", fg = C.blue, bg = C.surface0 })
            end

            table.insert(results, { text = "%@CloseAllBuffers@  ", fg = C.surface0, bg = C.red })
            return results
          end,
        }

      },

    }
  end
}

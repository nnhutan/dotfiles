---@diagnostic disable: need-check-nil, no-unknown
local icons = require("cores.icons")

local function file_type()
  local ft = vim.bo.filetype or ''
  return ft == "" and "{} plain text" or "{} " .. ft
end

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
end

local function LSP_status()
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" and client.name ~= "copilot" then
        return (vim.o.columns > 100 and "󰄭  " .. client.name) or "󰄭  LSP"
      end
    end
  end

  return ""
end

local function visualMultiMode()
  if vim.b["visual_multi"] then
    return " MULTI"
  else
    return ""
  end
end

local function visualMultiInfos()
  if vim.b["visual_multi"] then
    local result = vim.fn["VMInfos"]()
    -- local current = result.current
    -- local total = result.total
    local ratio = result.ratio
    local patterns = result.patterns
    -- local status = result.status
    return " " .. patterns[1] .. " " .. ratio
  else
    return ""
  end
end

return
{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config =
      function()
        local C = require("catppuccin.palettes").get_palette()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = { left = '', right = '' }, --
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
              statusline = { "dashboard", "alpha", "starter" },
              winbar = {},
            },
            ignore_focus = {},
            globalstatus = true,
          },
          sections = {
            lualine_a = { {} },
            lualine_b = {
              { 'mode', icons_enabled = true, icon = '', padding = { left = 1, right = 0 }, }
            },
            lualine_c = {
              { "tabs", },
              {
                'buffers',
                max_length = vim.o.columns * 2 / 3,
              },
            },
            lualine_x = {
              { visualMultiMode,  color = { fg = C.mauve }, },
              { visualMultiInfos, color = { fg = C.yellow }, separator = "|", },
              {
                'diagnostics',
                symbols = {
                  error = icons.diagnostics.Error,
                  warn = icons.diagnostics.Warn,
                  info = icons.diagnostics.Info,
                  hint = icons.diagnostics.Hint,
                },
              },
              {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = C.mauve },
              },
              {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has,
                color = { fg = C.mauve },
              },
              {
                'branch',
                icon = icons.kinds.Control,
                fmt = function(branch)
                  -- limit the length of the branch name
                  local max_width = 30
                  if string.len(branch) > max_width then
                    return string.sub(branch, 0, max_width - 3) .. "..."
                  end
                  return branch
                end,
              },
              {
                'diff',
                symbols = {
                  added = icons.git.added,
                  modified = icons.git.modified,
                  removed = icons.git.removed,
                },
                separator =
                "|",
                source = function()
                  local gitsigns = vim.b.gitsigns_status_dict
                  if gitsigns then
                    return {
                      added = gitsigns.added,
                      modified = gitsigns.changed,
                      removed = gitsigns.removed,
                    }
                  end
                end
              },
              { "encoding" },
              { file_type,                                   color = { fg = C.blue, } },
              { LSP_status,                                  color = { fg = C.blue, } },
              -- { 'require("copilot_status").status_string()', color = { fg = C.blue, }, padding = { left = 0, right = 1 } },
            },
            lualine_y = {
              { "location", padding = { left = 0, right = 1 } }
            },
            lualine_z = {}
          },
          extensions = {}
        }
      end
}

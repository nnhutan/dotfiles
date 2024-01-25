---@diagnostic disable: need-check-nil, no-unknown
local fn = vim.fn
local icons = require("cores.icons")

local function file_encoding()
  return string.upper(vim.opt.fileencoding:get())
end

local function file_type()
  local ft = vim.bo.filetype or ''
  return ft == "" and "{} plain text" or "{} " .. ft
end

local function cursor_position()
  return vim.o.columns > 140 and "Ln %l, Col %c" or ""
end

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
end

local function LSP_status()
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_active_clients()) do
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

local function cwd()
  local dir_name = "󰉖 " .. fn.fnamemodify(fn.getcwd(), ":t")
  return (vim.o.columns > 85 and dir_name) or ""
end

return
{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
  config =
      function()
        local C = require("catppuccin.palettes").get_palette()
        local get_theme = function()
          local flvr = require("catppuccin").flavour or vim.g.catppuccin_flavour or "frappe"
          if flvr == "frappe" then
            return {
              normal = {
                b = { bg = C.surface1, gui = 'bold', fg = C.blue },
                c = { bg = C.surface0, fg = C.overlay1 },
              },
              insert = { b = { bg = C.surface1, gui = 'bold', fg = C.mauve }, },
              visual = { b = { bg = C.surface1, gui = 'bold', fg = C.sky }, },
              replace = { b = { bg = C.surface1, gui = 'bold', fg = C.peach }, },
              command = { b = { bg = C.surface1, gui = 'bold', fg = C.green }, },
              inactive = { b = { bg = C.surface1, gui = 'bold', fg = C.text }, },
            }
          else
            return require("catppuccin.utils.lualine")(flvr)
          end
        end

        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = get_theme,
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
              statusline = { "dashboard", "alpha", "starter" },
              winbar = {},
            },
            ignore_focus = {},
            globalstatus = true,
          },
          sections = {
            lualine_a = {},
            lualine_b = {
              { 'mode', icons_enabled = true, icon = '', }
            },
            lualine_c = {
              { 'filetype', colored = false,           icon_only = true, padding = { left = 1, right = 0 } },
              { 'filename', separator = nil, },
              { 'branch',   icon = icons.kinds.Control },
              {
                'diagnostics',
                symbols = {
                  error = icons.diagnostics.Error,
                  warn = icons.diagnostics.Warn,
                  info = icons.diagnostics.Info,
                  hint = icons.diagnostics.Hint,
                },
              }
            },
            lualine_x = {
              {
                require("noice").api.status.command.get,
                cond = require("noice").api.status.command.has,
                color = { fg = C.mauve },
              },
              {
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = C.peach },
              },
              { visualMultiMode,  color = { fg = C.mauve --[[ , bg = C.surface1  ]] }, },
              { visualMultiInfos, color = { fg = C.yellow },                           separator = "|", },
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
              cursor_position,
              { file_encoding,                               color = { fg = C.peach, } },
              { file_type,                                   color = { fg = C.blue, } },
              { LSP_status,                                  color = { fg = C.blue, } },
              { 'require("copilot_status").status_string()', color = { fg = C.blue, }, padding = { left = 0, right = 1 } },
            },
            lualine_y = { { cwd, color = { fg = C.red } } },
            lualine_z = {}
          },
          extensions = {}
        }
      end
}

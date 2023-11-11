local fn = vim.fn
local icons = require("icons")

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

local colors = {
  text      = '#9598A5',
  red       = '#f07178',
  green     = '#c3e88d',
  blue      = '#82aaff',
  yellow    = '#ffcb6b',
  gray      = '#2f3344',
  lightgray = '#444859',
  purple    = "#c792ea",
  cyan      = "#89ddff",
  orange    = "#ffa282",
}


local function cwd()
  local dir_name = "󰉖 " .. fn.fnamemodify(fn.getcwd(), ":t")
  return (vim.o.columns > 85 and dir_name) or ""
end

return function()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = {
        normal = {
          b = { bg = colors.lightgray, gui = 'bold', fg = colors.blue },
          c = { bg = colors.gray, fg = colors.text },
        },
        insert = { b = { bg = colors.lightgray, gui = 'bold', fg = colors.purple }, },
        visual = { b = { bg = colors.lightgray, gui = 'bold', fg = colors.cyan }, },
        replace = { b = { bg = colors.lightgray, gui = 'bold', fg = colors.orange }, },
        command = { b = { bg = colors.lightgray, gui = 'bold', fg = colors.green }, },
        inactive = { b = { bg = colors.lightgray, gui = 'bold', fg = colors.text }, },
      },
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
        { visualMultiMode,  color = { fg = colors.purple, bg = colors.lightgray }, },
        { visualMultiInfos, color = { fg = colors.yellow },                        separator = "|", },
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
        { file_encoding,                               color = { fg = colors.orange, } },
        { file_type,                                   color = { fg = colors.blue, } },
        { LSP_status,                                  color = { fg = colors.green, } },
        { 'require("copilot_status").status_string()', color = { fg = colors.green, } }
      },
      lualine_y = { { cwd, color = { fg = colors.red, bg = colors.lightgray } } },
      lualine_z = {}
    },
    extensions = {}
  }
end

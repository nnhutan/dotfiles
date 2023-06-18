-- Default theme configuration
local default_theme = {
  -- Modify the color palette for the default theme
  colors = {
    fg = "#abb2bf",
    bg = "#1e222a",
  },

  highlights = function(hl) -- or a function that returns a new table of colors to set
    local C = require "default_theme.colors"

    hl.Normal = { fg = C.fg, bg = C.bg }

    -- New approach instead of diagnostic_style
    hl.DiagnosticError.italic = true
    hl.DiagnosticHint.italic = true
    hl.DiagnosticInfo.italic = true
    hl.DiagnosticWarn.italic = true

    return hl
  end,

  -- enable or disable highlighting for extra plugins
  plugins = { -- enable or disable extra plugin highlighting
    aerial = true,
    beacon = false,
    bufferline = true,
    cmp = true,
    dashboard = true,
    highlighturl = true,
    hop = false,
    indent_blankline = true,
    lightspeed = false,
    ["neo-tree"] = true,
    notify = true,
    ["nvim-tree"] = true,
    ["nvim-web-devicons"] = true,
    rainbow = true,
    symbols_outline = false,
    treesitter = true,
    telescope = true,
    vimwiki = false,
    ["which-key"] = true,
  },
}

return default_theme

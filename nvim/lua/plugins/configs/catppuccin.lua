return function()
  local ucolors = require('catppuccin.utils.colors')
  require("catppuccin").setup({
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = {      -- :h background
      light = "latte",
      dark = "frappe",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = true,               -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.6,             -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" },      -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {
      frappe = {
        -- rosewater = "#f2d5cf",
        -- 	flamingo = "#eebebe",
        -- 	pink = "#f4b8e4",
        -- 	mauve = "#ca9ee6",
        -- 	red = "#e78284",
        -- 	maroon = "#ea999c",
        -- 	peach = "#ef9f76",
        -- 	yellow = "#e5c890",
        -- 	green = "#a6d189",
        -- 	teal = "#81c8be",
        -- 	sky = "#99d1db",
        -- 	sapphire = "#85c1dc",
        -- 	blue = "#8caaee",
        -- 	lavender = "#babbf1",
        -- 	text = "#c6d0f5",
        -- 	subtext1 = "#b5bfe2",
        -- 	subtext0 = "#a5adce",
        -- 	overlay2 = "#949cbb",
        -- 	overlay1 = "#838ba7",
        -- 	overlay0 = "#737994",
        -- 	surface2 = "#626880",
        -- 	surface1 = "#51576d",
        -- 	surface0 = "#414559",
        -- 	base = "#303446",
        -- 	mantle = "#292c3c",
        -- 	crust = "#232634",

        -- #282C3D
        flamingo = "#82aaff",
        pink = "#f07178",
        -- pink = "#ff5572",
        mauve = "#c792ea",
        teal = "#c792ea",
        -- red = "#f07178",
        red = "#ff5572",
        -- maroon = "#f07178",
        -- peach = "#f07178",
        yellow = "#FFCB6B",
        green = "#c3e88d",
        sapphire = "#ffcb6b",
        blue = "#82aaff",
        text = "#BFC7D5",
        surface1 = "#3c4051", -- #51576d
        surface0 = "#2f3344",
        base = "#292D3E",
        mantle = "#232738", --"#232738", "#2f3344",
        crust = "#2f3344",
        overlay0 = "#4c5374",

      },
    },
    highlight_overrides = {
      frappe = function(colors)
        return {
          BufferLineIndicatorSelected = { fg = colors.pink },
          BufferLineIndicator = { fg = colors.base },
          BufferLineIndicatorVisible = { bg = colors.crust },
          BufferLineModifiedVisible = { bg = colors.crust, fg = colors.green },

          CursorLine = { bg = U.darken(colors.crust, 0.1, colors.mantle) },

          TabLineSel = { bg = colors.pink },
          TroubleNormal = { fg = colors.text, bg = colors.mantle },

          Visual = { bg = ucolors.darken(colors.blue, 0.1, colors.base) }, -- Visual Mode
          ['@namespace'] = { fg = colors.yellow, style = { 'bold' } },
          WinBar = { fg = colors.overlay0 },
          Special = { fg = colors.overlay0 },
          CurSearch = { bg = colors.mauve, fg = colors.mantle },
        }
      end
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      treesitter_context = true,
      notify = true,
      aerial = true,
      rainbow_delimiters = true,
      lsp_trouble = true,
      which_key = true,
      telescope = {
        enabled = true,
        style = "nvchad"
      },
      window_picker = true,
      mason = true,
      hop = true,
      neotest = true,
      noice = true,
      dropbar = {
        enabled = false,
        color_mode = true
      },
      harpoon = true,
      vimwiki = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  })
end

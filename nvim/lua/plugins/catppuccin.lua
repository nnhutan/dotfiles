return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 10000,
  lazy = false,
  config = function()
    local ucolors = require('catppuccin.utils.colors')
    require("catppuccin").setup({
      compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      flavour = vim.env.THEME_FLAVOUR or "mocha", -- latte, frappe, macchiato, mocha
      background = {                              -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
      term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
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
        keywords = { "italic" },
      },
      color_overrides = {},
      highlight_overrides = {
        all = function(colors)
          return {
            BufferLineIndicatorSelected = { fg = colors.pink },
            BufferLineIndicator = { fg = colors.base },
            BufferLineIndicatorVisible = { bg = colors.crust },
            BufferLineModifiedVisible = { bg = colors.crust, fg = colors.green },

            CursorLine = { bg = ucolors.darken(colors.crust, 0.1, colors.mantle) },

            TabLineSel = { bg = colors.pink },
            TroubleNormal = { fg = colors.text, bg = colors.mantle },

            Visual = { bg = ucolors.darken(colors.blue, 0.1, colors.base) }, -- Visual Mode
            WinBar = { fg = colors.overlay0 },
            Special = { fg = colors.overlay0 },
            CurSearch = { bg = colors.mauve, fg = colors.mantle },
          }
        end,
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

    vim.cmd "colorscheme catppuccin"
  end
}

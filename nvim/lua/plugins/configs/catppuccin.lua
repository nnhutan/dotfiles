return function()
  require("catppuccin").setup({
    compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = {      -- :h background
      light = "latte",
      dark = "frappe",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false,              -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15,            -- percentage of the shade to apply to the inactive window
    },
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = false,           -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" },      -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
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
        rosewater = "#f2d5cf",
        flamingo = "#eebebe",
        pink = "#ff5370",
        mauve = "#c792ea",
        red = "#f07178",
        maroon = "#ea999c",
        peach = "#ffa282",
        yellow = "#ffcb6b",
        green = "#c3e88d",
        teal = "#81c8be",
        sky = "#99d1db",
        sapphire = "#85c1dc",
        blue = "#82aaff",
        lavender = "#babbf1",
        text = "#d3d3d3",
        subtext1 = "#b5bfe2",
        subtext0 = "#a5adce",
        overlay2 = "#949cbb",
        overlay1 = "#838ba7",
        overlay0 = "#737994",
        surface2 = "#626880",
        surface1 = "#51576d",
        surface0 = "#2f3344",
        base = "#292D3E",
        mantle = "#232738", --"#232738", "#2f3344",
        crust = "#2f3344",
      },
    },
    custom_highlights = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
      aerial = true,
      rainbow_delimiters = true,
      lsp_trouble = true,
      which_key = true,
      telescope = {
        enabled = true,
        style = "nvchad"
      },
      mason = true,
      hop = true,
      neotest = true,
      noice = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  })
end

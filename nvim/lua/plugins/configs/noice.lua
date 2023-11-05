return function()
  require("noice").setup({
    views = {
      cmdline_popup = {
        win_options = {
          winhighlight = {
            Normal = "TelescopePromptNormal",
            FloatBorder = "TelescopePromptBorder",
          },
        },
        border = {
          highlight = "TelescopePromptBorder",
          padding = { 0, 0 },
        },
      },
      cmdline_popupmenu = {
        win_options = {
          winhighlight = {
            Normal = "TelescopePreviewNormal",      -- change to NormalFloat to make it look like other floats
            FloatBorder = "TelescopePreviewBorder", -- border highlight
            CursorLine = "TelescopeSelection",      -- used for highlighting the selected item
          },
        },
        border = {
          padding = { 0, 0 },
        },
      },
      confirm = {
        border = {
          style = "single",
          text = { top = "Are you sure?" },
        },
        win_options = {
          winhighlight = {
            Normal = "TelescopePreviewNormal",
            FloatBorder = "TelescopePreviewBorder",
          },
        },
      },
    },
    lsp = {
      progress = {
        enabled = true
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = { enabled = true, },
      hover = { enabled = true, },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false,        -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
  })
end

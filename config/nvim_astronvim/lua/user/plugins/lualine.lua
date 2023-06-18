return function()
  require("lualine").setup {
    -- options = { theme = "catppuccin" },
    -- options = { theme = "nightfly" },
    options = {
      theme = "ayu_mirage",
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },
      -- component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path, 3: Absolute path, with tilde as the home directory
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window. for other components. (terrible name, any suggestions?)
          symbols = {
            modified = "[+]", -- Text to show when the file is modified.
            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]", -- Text to show for new created file before first writting
          },
        },
        "lsp_progress",
      },
      lualine_x = {
        function()
          local icon = " "
          local clients = {}

          for _, client in pairs(vim.lsp.buf_get_clients(0)) do
            clients[#clients + 1] = client.name
          end
          if #clients == 0 then return " No Active Lsp" end
          return icon .. table.concat(clients, ", ")
        end,
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  }
end

return function()
  require "alpha.term"
  local dashboard = require "alpha.themes.dashboard"
  dashboard.section.padding = function(lines) return { type = "padding", val = lines } end
  dashboard.section.terminal.command = "cat | cat ~/.config/nvim/lua/logo.cat"
  dashboard.section.terminal.width = 70
  dashboard.section.terminal.height = 10
  dashboard.section.terminal.opts.redraw = true
  dashboard.section.terminal.opts.window_config.zindex = 1
  dashboard.section.header.val = "  𝕟 𝕖 𝕠 𝕧 𝕚 𝕞  "

  dashboard.section.project = {
    type = "text",
    val = vim.fn.fnamemodify(vim.fn.getcwd(), ":t"):upper(),
    opts = { hl = "AlphaTitle", position = "center", },
  }

  dashboard.section.buttons = {
    type = "group",
    val = {
      dashboard.button("n", "  Create file", "<Cmd>ene<CR>"),
      dashboard.button("p", "  Explore project", "<cmd> Telescope projections <cr>"),
      dashboard.button("f", "  Find file", "<cmd> Telescope find_files <cr>"),
      dashboard.button("w", "  Find text", "<cmd> Telescope live_grep <cr>"),
      dashboard.button("s", "  Setting", "<cmd> e ~/.config/nvim/init.lua <cr>"),
      dashboard.button("q", "  Quit", "<Cmd>qa<CR>"),
    },
    opts = {
      spacing = 1,
    },
  }
  dashboard.section.buttons.opts.hl = "Normal"
  dashboard.section.footer = {
    type = "text",
    val = "Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
    opts = { hl = "Comment", position = "center", },
  }

  dashboard.opts.layout = {
    dashboard.section.padding(12),
    dashboard.section.terminal,
    dashboard.section.padding(2),
    dashboard.section.project,
    dashboard.section.padding(1),
    dashboard.section.buttons,
    dashboard.section.padding(1),
    dashboard.section.footer,
    dashboard.section.padding(1),
    dashboard.section.header,
  }

  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "AlphaReady",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "LazyVimStarted",
    callback = function()
      local lazy = require "lazy"

      local stats = lazy.stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

      dashboard.section.header.val = "  Neovim loaded " ..
          stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      vim.fn.timer_start(0, function()
        pcall(vim.cmd.AlphaRedraw)
      end)
    end
  })
end

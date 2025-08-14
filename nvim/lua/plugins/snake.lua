return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      style = "minimal",
    },
    styles = {
      ["notification.history"] = {
        border = "rounded",
        zindex = 100,
        width = 0.6,
        height = 0.6,
        minimal = false,
        title = " Notification History ",
        title_pos = "center",
        ft = "markdown",
        bo = { filetype = "snacks_notif_history" },
        wo = { winhighlight = "Normal:TelescopePreviewNormal,FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopePreviewTitle" },

        keys = { q = "close" },
      },
      notification = {
        wo = {
          winblend = 5,
          wrap = true,
          conceallevel = 2,
          colorcolumn = "",
        },
      },
      scratch = {
        width = 0.5,
        height = 0.5,
        wo = { winhighlight = "Normal:TelescopeResultsNormal,FloatBorder:TelescopeResultsBorder" },
      }
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    bufdelete = { enabled = true },
    scratch = { enabled = true },
  },
  keys = {
    { "<leader>bC", function() Snacks.bufdelete.all() end,         desc = "Close all buffers" },
    { "<leader>bc", function() Snacks.bufdelete.other() end,       desc = "Close all buffers except current" },
    { "<leader>c",  function() Snacks.bufdelete() end,             desc = "Delete Buffer" },
    { "<leader>fN", function() Snacks.notifier.show_history() end, desc = "Notifications history" },
    { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss all Notifications" },
    { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
    { "<leader>f.", function() Snacks.scratch.select() end,        desc = "Select Scratch Buffer" },
  },
  config = function(_, opts)
    local notify = vim.notify
    require("snacks").setup(opts)
    vim.notify = notify
  end,
}

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local stages = require "notify.stages.slide" "bottom_up"
    local notify = require "notify"
    if not unpack then
      unpack = table.unpack
    end
    notify.setup {
      timeout = 1500,
      background_colour = "Normal",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      render = "compact",
      fps = 60,

      stages = {
        function(...)
          local opts = stages[1](...)
          if opts then
            opts.border = "none"
          end
          return opts
        end,
        unpack(stages, 2),
      },
    }
    vim.notify = notify
  end
}

return {
  'akinsho/toggleterm.nvim',
  cmd = "ToggleTerm",
  version = "*",
  enabled = false,
  opts =
  {
    start_in_insert = true,
    persist_mode = false,
    highlights = {
      NormalFloat = {
        link = 'TelescopeResultsNormal'
      },
      FloatBorder = {
        link = 'TelescopeResultsBorder'
      },
    },
    float_opts = {
      width = vim.o.columns,
      height = vim.o.lines,
    },
    autochdir = false,
  },
  keys = { { '<c-t>', '<cmd>ToggleTerm direction=float<CR>', mode = 'n', desc = "Terminal" }, },
}

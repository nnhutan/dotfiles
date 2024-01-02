return {
  start_in_insert = true,
  persist_mode = false,
  highlights = {
    NormalFloat = {
      link = 'Normal'
    },
    FloatBorder = {
      guibg = "#292d3e",
      guifg = "#292d3e"
    },
  },
  float_opts = {
    width = vim.o.columns,
    height = vim.o.lines,
  },
  autochdir = false,
}

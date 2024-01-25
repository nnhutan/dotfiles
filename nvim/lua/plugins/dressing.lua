return {
  'stevearc/dressing.nvim',
  opts = {},
  config =
      function()
        require("dressing").setup({
          input = {
            prompt_align = "center",
            win_options = {
              winhighlight =
              "FloatNormal:TelescopePreviewNormal,FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopePreviewTitle",
            },
          },
        })
      end
}

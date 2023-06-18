local cfg = {
  -- floating_window = false,
  -- hint_enable = false,
  -- auto_close_after = 2,
  toggle_key = "<C-x>",
  -- move_cursor_key = "<tab>",
  select_signature_key = "<C-n>", -- imap, use nvim_set_current_win to move cursor between current win and floating
}
require("lsp_signature").setup(cfg)
return function()
  require("lsp_signature").setup(cfg)
end

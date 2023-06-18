-- set vim options here (vim.<first_key>.<second_key> =  value)
local options = {
  opt = {
    -- relativenumber = true, -- sets vim.opt.relativenumber
    hlsearch = true,
    wrap = true,
    title = true,
    cmdheight = 1,
    redrawtime = 10000,
    -- synmaxcol = 128,
    linebreak = true,
  },
  g = {
    mapleader = " ",                 -- sets vim.g.mapleader
    autoformat_enabled = true,       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true,              -- enable completion at start
    autopairs_enabled = true,        -- enable autopairs at start
    diagnostics_enabled = true,      -- enable diagnostics at start
    status_diagnostics_enabled = true, -- enable diagnostics in statusline
    icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    heirline_bufferline = false,     -- enable new heirline based bufferline (requires :PackerSync after changing)
    -- catppuccin_flavour = "macchiato", -- latte, frappe, macchiato, mocha

    --[[ neon_style = "doom", -- default, dark, doom, light ]]
    --[[ neon_italic_keyword = true, ]]
    --[[ neon_italic_function = true, ]]
    -- neon_transparent = true,

    nightflyCursorColor = true,
    nightflyItalics = true,
    nightflyNormalFloat = true,
    nightflyTerminalColors = true,
    -- [[ nightflyTransparent = true, ]]
    nightflyUndercurls = true,
    nightflyUnderlineMatchParen = true,
    re = 0,
    --[[ moonlight_italic_comments = true, ]]
    --[[ moonlight_italic_keywords = true, ]]
    --[[ moonlight_italic_functions = true, ]]
    --[[ moonlight_italic_variables = false, ]]

    --[[ moonlight_contrast = true, ]]
    --[[ moonlight_borders = false, ]]
    --[[ moonlight_disable_background = false, ]]

    --[[ material_style = "deep ocean", --palenight, darker, lighter, oceanic, deep ocean ]]

    copilot_filetypes = { ["*"] = true },
    copilot_no_tab_map = true,
    copilot_assume_mapped = true,
  },
  o = {
    regexpengine = 1,
    lazyredraw = true,
    ttyfast = true,
    cmdheight = 1,
    foldlevel = 200,
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
  },
}
-- If you need more control, you can use the function()...end notation
-- options = function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end,

return options

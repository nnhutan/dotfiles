-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true,         -- sets vim.opt.number
    spell = false,         -- sets vim.opt.spell
    -- signcolumn = "auto",   -- sets vim.opt.signcolumn to auto
    wrap = true,           -- sets vim.opt.wrap
    title = true,
    linebreak = true,
    -- redrawtime = 10000,
    -- shell = "/bin/bash",
    -- synmaxcol = 128,
    -- foldlevel = 20,
    -- foldmethod = "expr",
    -- foldexpr = "nvim_treesitter#foldexpr()",
    -- cmdheight = 1,
  },
  g = {
    rspec_command = "!rspec --drb {spec}",
    rspec_runner = "os_x_iterm2",
    mapleader = " ",                 -- sets vim.g.mapleader
    autoformat_enabled = true,       -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true,              -- enable completion at start
    autopairs_enabled = true,        -- enable autopairs at start
    diagnostics_mode = 3,            -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true,            -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    -- heirline_bufferline = false,     -- enable new heirline based bufferline (requires :PackerSync after changing)
    copilot_no_tab_map = true,
    copilot_filetypes = { ["*"] = true },
    matchup_matchparen_offscreen = { method = 'popup' },
    lazyredraw = true,
    ttyfast = true,
    ['test#neovim#start_normal'] = 1,
    ['test#strategy'] = {
      nearest = 'neovim',
      file = 'neovim',
      suite = 'neovim'
    }
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end

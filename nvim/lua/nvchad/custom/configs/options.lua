local opt = vim.opt
local g = vim.g

opt.foldcolumn = "1"
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.relativenumber = true -- Show relative numberline
-- opt.fillchars = [[eob: ,fold: ,foldopen:⌄,foldsep: ,foldclose:>]]
-- opt.statuscolumn =
--   '%=%l%s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "⌄" : ">") : " " }'
opt.statuscolumn =
  '%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "-" : "+") : "│") : " " }'
opt.cmdheight = 1
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.scrolloff = 8

g.copilot_no_tab_map = true
g.copilot_filetypes = { ["*"] = true }
g.matchup_matchparen_offscreen = { method = "popup" }
g.nvimtree_side = "left"
g.autoformat_enabled = true
g.ruby_host_prog = "~/.rbenv/shims/neovim-ruby-host"
-- g.loaded_ruby_provider = nil
g.nocompatible = true
g.regexpengine = 1
g.ttyfast = true
g.lazyredraw = true
g["escape-time"] = 10
-- g.rspec_command = "!rspec --drb {spec}"
-- g.rspec_runner = "os_x_iterm2"
g["test#neovim#start_normal"] = 1
g["test#strategy"] = {
  nearest = "neovim",
  file = "neovim",
  suite = "neovim",
}

local opt = vim.opt
local g = vim.g
-- local go = vim.go

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.relativenumber = true -- Show relative numberline
opt.statuscolumn =
	'%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "-" : "+") : "│") : " " }'
opt.cmdheight = 0
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.scrolloff = 8
opt.termguicolors = true
opt.updatetime = 200

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
g["test#neovim#start_normal"] = 1
g["test#strategy"] = {
	nearest = "neovim",
	file = "neovim",
	suite = "neovim",
}

-- go.lazyredraw = true

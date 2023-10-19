local opt = vim.opt
local g = vim.g
-- local go = vim.go

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,stlnc:─,stl:─]]
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.relativenumber = true
opt.cmdheight = 0
opt.scrolloff = 8
opt.termguicolors = true
opt.updatetime = 200
-- opt.wildmode = "longest:full,full"
opt.laststatus = 0
opt.statusline = "%#StatusLine#"
g.tpipeline_clearstl = 1
g.copilot_no_tab_map = true
g.copilot_filetypes = { ["*"] = true }
g.nvimtree_side = "left"
g.matchup_matchparen_offscreen = { method = "popup" }
g.autoformat_enabled = true
g.ruby_host_prog = "~/.rbenv/shims/neovim-ruby-host"
g.nocompatible = true
g.regexpengine = 1
g.ttyfast = true
-- g.lazyredraw = true
g["escape-time"] = 10
g["test#neovim#start_normal"] = 1
g["test#strategy"] = {
	nearest = "neovim",
	file = "neovim",
	suite = "neovim",
}
g.dashboard_disable_statusline = 1

-- go.lazyredraw = true

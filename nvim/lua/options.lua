local opt = vim.opt
local g = vim.g

opt.showmode = false
opt.clipboard = "unnamedplus"
opt.cursorline = false
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.ignorecase = true
opt.mouse = "a"
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false
opt.shortmess:append "sI"
opt.timeoutlen = 400
opt.undofile = true
opt.whichwrap:append "<>[]hl"
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff:╱,]]
opt.foldcolumn = "1"
opt.cmdheight = 0
opt.scrolloff = 8
opt.termguicolors = true
opt.updatetime = 200
opt.signcolumn = "yes"
opt.laststatus = 3
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.statuscolumn = [[%!v:lua.require'utils'.statuscolumn()]]
opt.smoothscroll = true

g.mapleader = " "
g.matchup_matchparen_offscreen = { method = "popup" }
g.ruby_host_prog = "~/.rbenv/shims/neovim-ruby-host"
g.nocompatible = true
g.regexpengine = 1
g.ttyfast = true
g["escape-time"] = 0
g["test#neovim#start_normal"] = 1
g["test#strategy"] = { nearest = "neovim", file = "neovim", suite = "neovim" }
g.markdown_recommended_style = 0
g.VM_set_statusline = 0
g.VM_silent_exit = 1

opt.foldlevel = 99
opt.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldtext = "v:lua.require'utils'.foldtext()"
vim.o.formatexpr = "v:lua.vim.lsp.formatexpr({ timeout_ms = 3000 })"

vim.cmd("hi NeogitDiffDeleteHighlight guibg=#404040 guifg=#ff6b6f")

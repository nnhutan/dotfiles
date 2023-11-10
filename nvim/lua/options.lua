local opt = vim.opt
local g = vim.g
local api = vim.api

opt.showmode = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
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
opt.breakindent = true
opt.linebreak = true
opt.virtualedit = "block"
opt.wrap = false
opt.writebackup = false
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- opt.omnifunc = 'v:lua.vim.treesitter.query.omnifunc'
opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
-- opt.foldtext = 'v:lua.vim.treesitter.foldtext()'


g.mapleader = " "
g.matchup_matchparen_offscreen = { method = "popup" }
g.loaded_ruby_provider = 0
g.nocompatible = true
g.ttyfast = true
g["escape-time"] = 0
g["test#neovim#start_normal"] = 1
g["test#strategy"] = { nearest = "neovim", file = "neovim", suite = "neovim" }
g.markdown_recommended_style = 0
g.VM_set_statusline = 0
g.VM_silent_exit = 1

vim.cmd([[
  hi! link LazyGitFloat TelescopePreviewNormal
]])

vim.cmd([[
  hi! link LazyGitBorder TelescopePreviewBorder
]])

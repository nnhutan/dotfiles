-- general

-- LunarVim settings
lvim.log.level = "warn"
lvim.format_on_save = true
-- LunarVim themme
lvim.colorscheme = "dracula"
-- lvim.transparent_window = true
-- lvim.use_icons = false
lvim.leader = "space"

-- builtin plugins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "ruby",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.theme = 'dracula'


-----------------------------------------------------------
-- Neovim settings
--- General Neovim settings
-----------------------------------------------------------
-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
-- local cmd = vim.cmd     		-- execute Vim commands
-- local exec = vim.api.nvim_exec 	-- execute Vimscript
-- local fn = vim.fn       		-- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options


opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.wrap = true -- line wrapping
opt.linebreak = true -- don't split words

opt.syntax = 'enable' -- enable syntax highlighting
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
opt.relativenumber = true -- show relative distance between rows
-- opt.scrolloff = 10            -- keep 10 row buffer on screen edges
opt.foldmethod = 'marker' -- enable folding (default 'foldmarker')
-- opt.colorcolumn = '80' -- line length marker at 80 columns
-- opt.splitright = true -- vertical split to the right
-- opt.splitbelow = true         -- horizontal split to the bottom
-- opt.ignorecase = true         -- ignore case letters when search
-- opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.hlsearch = false -- remove highlighting after search
opt.lazyredraw = true
opt.smartindent = true
opt.titlestring = "%<%F%=%l/%L - nvim"

-- config copilot
g.copilot_no_tab_map = true
g.copilot_assume_mapped = true
g.copilot_tab_fallback = ""

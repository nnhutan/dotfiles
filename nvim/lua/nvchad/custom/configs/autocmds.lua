local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- local cmd = vim.api.nvim_create_user_command
-- local namespace = vim.api.nvim_create_namespace

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
})

autocmd("BufEnter", {
	desc = "Open Neo-Tree on startup with directory",
	group = augroup("neotree_start", { clear = true }),
	callback = function()
		if package.loaded["neo-tree"] then
			vim.api.nvim_del_augroup_by_name("neotree_start")
		else
			local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
			if stats and stats.type == "directory" then
				vim.api.nvim_del_augroup_by_name("neotree_start")
				require("neo-tree")
			end
		end
	end,
})

autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.cmd([[ :mkview ]])
		vim.lsp.buf.format({ timeout = 2000, async = false })
	end,
})

autocmd("BufWritePost", {
	pattern = "*",
	callback = function()
		vim.cmd(":silent! loadview")
	end,
})

autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = augroup("highlightyank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("FileType", {
	pattern = "eruby.yaml",
	command = "set filetype=yaml",
})

autocmd({
	"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include this if you have set `show_modified` to `true`
	"BufModifiedSet",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})

vim.cmd([[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
]])

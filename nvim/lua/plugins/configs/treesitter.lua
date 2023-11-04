require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "vim", "vimdoc", "tsx", "html", "css", "typescript", "javascript" },

  indent = { enable = true },

	rainbow = {
		enable = true,
		-- list of languages you want to disable the plugin for
		disable = { "jsx", "cpp" },
		-- Which query to use for finding delimiters
		query = "rainbow-parens",
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		use_languagetree = true,
		disable = function(_, bufnr)
			if vim.bo.filetype == "help" then
				return true
			elseif vim.bo.filetype == "lua" then
				return true
			else
				local buf_name = vim.api.nvim_buf_get_name(bufnr)
				local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
				return file_size > 256 * 1024
			end
		end,
	},

}

local M = {}
local cmp = require("cmp")

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"c",
		"markdown",
		"markdown_inline",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
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
		use_languagetree = false,
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

M.mason = {
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",

		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettier",

		-- c/cpp stuff
		"clangd",
		"clang-format",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

M.telescope = {
	defaults = {
		mappings = {
			i = {
				["<C-n>"] = require("telescope.actions").cycle_history_next,
				["<C-p>"] = require("telescope.actions").cycle_history_prev,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-o>"] = function(prompt_bufnr)
					require("telescope.actions").select_default(prompt_bufnr)
					require("telescope.builtin").resume()
				end,
			},
			n = {
				["<C-o>"] = function(prompt_bufnr)
					require("telescope.actions").select_default(prompt_bufnr)
					require("telescope.builtin").resume()
				end,
			},
		},
	},
	extensions = {},
}

M.gitsigns = {
	current_line_blame = true,
}

M.cmp = {
	sources = {
		-- { name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	},
	preselect = cmp.PreselectMode.None,
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
}

M.blankline = {
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"nvdash",
		"nvcheatsheet",
		"neo-tree",
		"notify",
		"dashboard",
		"noice",
		"",
	},
}

return M

function FuzzyFindFiles()
	local input_string = vim.fn.input("Search For > ")
	if input_string == "" then
		return
	end
	require("telescope.builtin").grep_string({ search = input_string })
end

function CopyFilePath(type)
	local filepath = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t")
	local modify = vim.fn.fnamemodify

	local results = {
		e = { val = modify(filename, ":e"), msg = "Extension only" },
		f = { val = filename, msg = "Filename" },
		F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
		h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
		p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
		P = { val = filepath, msg = "Absolute path" },
	}

	local result = results[type]
	if result and result.val and result.val ~= "" then
		vim.notify("Copied: " .. result.val)
		vim.fn.setreg("+", result.val)
	end
end

---@type MappingsTable
local M = {}

M.general = {
	i = {
		-- go to  beginning and end
		["<C-b>"] = { "<ESC>^i", "Beginning of line" },
		["<C-e>"] = { "<End>", "End of line" },

		-- navigate within insert mode
		-- ["<C-h>"] = { "<Left>", "Move left" },
		-- ["<C-l>"] = { "<Right>", "Move right" },
		-- ["<C-j>"] = { "<Down>", "Move down" },
		-- ["<C-k>"] = { "<Up>", "Move up" },
	},

	n = {
		["]t"] = { "<cmd> tabNext <CR>", "Next tabs group" },
		["[t"] = { "<cmd> tabprevious <CR>", "Prev tabs group" },

		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		["<leader>w"] = { "<cmd> w <CR>", "Save file" },
		["<Esc>"] = { ":noh <CR>", "Clear highlights", opts = { silent = true } },
		-- switch between windows
		["<C-h>"] = { "<C-w>h", "Window left" },
		["<C-l>"] = { "<C-w>l", "Window right" },
		["<C-j>"] = { "<C-w>j", "Window down" },
		["<C-k>"] = { "<C-w>k", "Window up" },

		-- save
		["<C-s>"] = { "<cmd> w <CR>", "Save file" },
		["<leader>q"] = { "<cmd> q <CR>", "Quit" },
		["<leader>Q"] = { "<cmd> qa <CR>", "Quit all" },

		-- Copy all
		["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

		["<leader>fm"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
		-- split
		["|"] = { "<cmd>vsplit<cr>", "Vertical Split" },
		["\\"] = { "<cmd>split<cr>", "Horizontal Split" },
		-- resize
		["<C-Up>"] = { "<cmd>resize -2<CR>", "Resize split up" },
		["<C-Down>"] = { "<cmd>resize +2<CR>", "Resize split down" },
		["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Resize split left" },
		["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Resize split right" },

		-- copy file path
		["<leader>fp"] = { "<cmd>lua CopyFilePath('p')<CR>", "Path relative to CWD" },
		["<leader>fh"] = { "<cmd>lua CopyFilePath('h')<CR>", "Path relative to Home" },
		["<leader>fP"] = { "<cmd>lua CopyFilePath('P')<CR>", "Absolute path" },
		["<leader>fe"] = { "<cmd>lua CopyFilePath('e')<CR>", "Extension only" },
		["<leader>fn"] = { "<cmd>lua CopyFilePath('f')<CR>", "Filename" },
		["zR"] = {
			function()
				require("ufo").openAllFolds()
			end,
			"Open all Folds v2",
		},
		["zM"] = {
			function()
				require("ufo").closeAllFolds()
			end,
			"Close all Folds v2",
		},
	},

	t = {
		["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
	},

	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["<S-Tab>"] = { "<gv", "Unindent line" },
		["<Tab>"] = { ">gv", "Indent line" },
	},

	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
	},
}

M.tabufline = {
	plugin = true,

	n = {
		-- cycle through buffers
		["L"] = {
			function()
				require("nvchad.tabufline").tabuflineNext()
			end,
			"Goto next buffer",
		},

		["H"] = {
			function()
				require("nvchad.tabufline").tabuflinePrev()
			end,
			"Goto prev buffer",
		},

		-- close buffer + hide terminal buffer
		["<leader>c"] = {
			function()
				require("nvchad.tabufline").close_buffer()
			end,
			"Close buffer",
		},

		["<leader>bn"] = { "<cmd> enew <CR>", "New buffer" },
		["<leader>bc"] = {
			function()
				require("nvchad.tabufline").closeOtherBufs()
			end,
			"Close all buffers except current",
		},
		["<leader>bC"] = {
			function()
				require("nvchad.tabufline").closeAllBufs()
			end,
			"Close all buffers",
		},
		["<leader>bh"] = {
			function()
				require("nvchad.tabufline").move_buf(-1)
			end,
			"Move left",
		},
		["<leader>bl"] = {
			function()
				require("nvchad.tabufline").move_buf(1)
			end,
			"Move right",
		},
	},
}

M.comment = {
	plugin = true,

	-- toggle comment in both modes
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
	},
}

M.lspconfig = {
	plugin = true,

	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

	n = {
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"LSP declaration",
		},

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"LSP hover",
		},

		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"LSP implementation",
		},

		["<leader>lh"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},

		["<leader>la"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},

		["<leader>D"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"LSP definition type",
		},

		["<leader>lr"] = {
			function()
				require("nvchad.renamer").open()
			end,
			"LSP rename",
		},

		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},

		["<leader>ld"] = {
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			"Floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev({ float = { border = "rounded" } })
			end,
			"Goto prev",
		},

		["]d"] = {
			function()
				vim.diagnostic.goto_next({ float = { border = "rounded" } })
			end,
			"Goto next",
		},

		["<leader>lf"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"LSP formatting",
		},

		["<leader>ls"] = {
			function()
				local aerial_avail, _ = pcall(require, "aerial")
				if aerial_avail then
					require("telescope").extensions.aerial.aerial()
				else
					require("telescope.builtin").lsp_document_symbols()
				end
			end,
			"Search symbols",
		},
		["<leader>lS"] = {
			function()
				require("aerial").toggle()
			end,
			"Symbols outline",
		},
	},
}

M.telescope = {
	plugin = true,

	n = {
		-- find
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
		["<leader>fF"] = {
			"<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
			"Find files (all)",
		},
		["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Find words" },
		["<leader>fW"] = {
			function()
				require("telescope.builtin").live_grep({
					additional_args = function(args)
						return vim.list_extend(args, { "--hidden", "--no-ignore" })
					end,
				})
			end,
			"Find words (all)",
		},
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
		-- ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
		["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
		["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
		["<leader>fs"] = { "<cmd>lua FuzzyFindFiles{}<CR>", "Grep string" },

		-- git
		["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
		["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

		-- pick a hidden term
		["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

		-- theme switcher
		["<leader>ft"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

		["<leader>fa"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
	},
}

M.nvterm = {
	plugin = true,

	t = {
		-- toggle in terminal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"Toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"Toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"Toggle vertical term",
		},
	},

	n = {
		-- toggle in normal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"Toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"Toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"Toggle vertical term",
		},

		-- new
		["<leader>h"] = {
			function()
				require("nvterm.terminal").new("horizontal")
			end,
			"New horizontal term",
		},

		["<leader>v"] = {
			function()
				require("nvterm.terminal").new("vertical")
			end,
			"New vertical term",
		},
	},
}

M.whichkey = {
	plugin = true,
}

M.blankline = {
	plugin = true,

	n = {},
}

M.gitsigns = {
	plugin = true,

	n = {
		-- Navigation through hunks
		["]g"] = {
			function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return "<Ignore>"
			end,
			"Jump to next hunk",
			opts = { expr = true },
		},

		["[g"] = {
			function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return "<Ignore>"
			end,
			"Jump to prev hunk",
			opts = { expr = true },
		},

		["<leader>gp"] = {
			function()
				require("gitsigns").preview_hunk()
			end,
			"Preview hunk",
		},

		["<leader>gl"] = {
			function()
				package.loaded.gitsigns.blame_line()
			end,
			"Blame line",
		},

		["<leader>gd"] = {
			function()
				require("gitsigns").diffthis()
			end,
			"Git diff",
		},
	},
}

M.hop = {
	n = {
		["<leader>j"] = { "<cmd>HopWord<cr>", "Jump to word" },
	},
}
require("core.utils").load_mappings("hop")

M.test = {
	n = {
		["<leader>Tf"] = { "<cmd>TestFile -strategy=neovim<CR>", "Test file" },
		["<leader>Tn"] = { "<cmd>TestNearest<CR>", "Test nearest" },
		["<leader>Tc"] = { "<cmd>TestClass<CR>", "Test class" },
		["<leader>Ts"] = { "<cmd>TestSuite<CR>", "Test suite" },
	},
}
require("core.utils").load_mappings("test")

M.neotree = {
	plugin = true,

	n = {
		["<leader>e"] = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
		["<leader>o"] = {
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end,
			"Toggle Explorer Focus",
		},
	},
}
require("core.utils").load_mappings("neotree")

M.spectre = {
	plugin = true,

	n = {
		["<leader>s"] = { "<cmd>Spectre<cr>", "Search panel" },
	},
}
require("core.utils").load_mappings("spectre")

M.trouble = {
	plugin = true,

	n = {
		["<leader>lt"] = { "<cmd>Trouble<cr>", "Code problems" },
	},
}
require("core.utils").load_mappings("trouble")

M.persistence = {

	plugin = true,
	n = {
		["<leader>Ss"] = { '<cmd>lua require("persistence").load()<cr>', "Load current session" },
		["<leader>a"] = { '<cmd>lua require("persistence").load()<cr>', "Load current session" },
		["<leader>Sl"] = { '<cmd>lua require("persistence").load({ last = true })<cr>', "Load last session" },
		["<leader>Sq"] = { '<cmd>lua require("persistence").stop()<cr>', "Stop persistence" },
	},
}
require("core.utils").load_mappings("persistence")

M.notify = {

	plugin = true,
	n = {
		["<leader>un"] = {
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			"Dismiss all Notifications",
		},
	},
}
require("core.utils").load_mappings("notify")

M.GPT = {

	plugin = true,
	n = {
		["<leader>G"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
		["<leader>kc"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
		["<leader>ke"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
		["<leader>kg"] = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
		["<leader>kt"] = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
		["<leader>kk"] = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
		["<leader>kd"] = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
		["<leader>ka"] = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
		["<leader>ko"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
		["<leader>ks"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
		["<leader>kf"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
		["<leader>kx"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
		["<leader>kr"] = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
		["<leader>kl"] = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
	},

	v = {
		["<leader>ke"] = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
		["<leader>kg"] = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
		["<leader>kt"] = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
		["<leader>kk"] = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
		["<leader>kd"] = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
		["<leader>ka"] = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
		["<leader>ko"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
		["<leader>ks"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
		["<leader>kf"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
		["<leader>kx"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
		["<leader>kr"] = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
		["<leader>kl"] = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
	},
}
require("core.utils").load_mappings("GPT")

M.copilot = {

	plugin = true,
	i = {
		["<C-l>"] = {
			'copilot#Accept("<CR>")',
			"Copilot accept",
			opts = { silent = true, expr = true, replace_keycodes = false },
		},
		["<C-k>"] = {
			'copilot#Accept("<CR>")',
			"Copilot accept",
			opts = { silent = true, expr = true, replace_keycodes = false },
		},
		["<C-j>"] = {
			'copilot#Accept("<CR>")',
			"Copilot accept",
			opts = { silent = true, expr = true, replace_keycodes = false },
		},
		["<C-h>"] = {
			'copilot#Accept("<CR>")',
			"Copilot accept",
			opts = { silent = true, expr = true, replace_keycodes = false },
		},
	},
}
if vim.fn.exists(":Copilot") == 2 then
	vim.cmd([[autocmd User CopilotEnter :lua require("core.utils").load_mappings("copilot")]])
	-- require("core.utils").load_mappings("copilot")
end

M.disabled = {
	n = {
		["<leader>wK"] = "",
		["<leader>wk"] = "",
		["<leader>cc"] = "",
		["<leader>wa"] = "",
		["<leader>wr"] = "",
		["<leader>wl"] = "",
		["<leader>ca"] = "",
		["<leader>q"] = "",
		["<leader>b"] = "",
		["]c"] = "",
		["[c"] = "",
		["<leader>rh"] = "",
		["<leader>ph"] = "",
		["<leader>gb"] = "",
		["<leader>td"] = "",
		["<leader>fa"] = "",
		["<leader>fm"] = "",
		["<leader>ra"] = "",
		["<C-n>"] = "",
		["<leader>n"] = "",
		["<leader>rn"] = "",
		["<leader>ch"] = "",
		["<leader>th"] = "",
		["<leader>cm"] = "",
		["<leader>ma"] = "",
		["<leader>f"] = "",
		["<leader>e"] = "",
		["<leader>o"] = "",
		["<leader>fh"] = "",
		["zR"] = "",
		["zM"] = "",
	},
}

return M

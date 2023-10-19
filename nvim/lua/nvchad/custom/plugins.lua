local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{ "vimpostor/vim-tpipeline", event = "BufReadPre" },
	{ "nvim-pack/nvim-spectre", cmd = "Spectre" },
	{ "tpope/vim-haml", event = "VeryLazy" },
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{ "thoughtbot/vim-rspec", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", event = "VeryLazy" },
	{ "vim-test/vim-test", event = "VeryLazy" },
	{ "rhysd/clever-f.vim", event = "VeryLazy" },
	{ "wakatime/vim-wakatime", lazy = false },
	{ "williamboman/mason.nvim", opts = overrides.mason },
	{ "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
	{ "nvim-telescope/telescope.nvim", opts = overrides.telescope },
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
	{ "lewis6991/gitsigns.nvim", opts = overrides.gitsigns },
	{ "hrsh7th/nvim-cmp", opts = overrides.cmp },
	{ "lukas-reineke/indent-blankline.nvim", opts = overrides.blankline },
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		config = function(_, opts)
			-- default config function's stuff
			dofile(vim.g.base46_cache .. "whichkey")
			require("which-key").setup(opts)

			-- your custom stuff
			require("which-key").register({
				b = { name = "Buffer" },
				g = { name = "Git" },
				f = { name = "Find" },
				l = { name = "LSP" },
				T = { name = "Test" },
				p = { name = "Others" },
				S = { name = "Session" },
				k = { name = "GPT" },
			}, { prefix = "<leader>" })
		end,
	},
	{ "nvim-tree/nvim-tree.lua", enabled = false },
	{ "mg979/vim-visual-multi", event = "VeryLazy", branch = "master" },
	{ "tpope/vim-rails", event = "VeryLazy" },
	{ "mattn/emmet-vim", event = "VeryLazy" },
	{ "folke/persistence.nvim", event = "BufReadPre", opts = {} },
	{ "gsuuon/note.nvim", cmd = "Note" },
	-- { "github/copilot.vim", lazy = false },
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
		event = "BufReadPre",
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			dofile(vim.g.base46_cache .. "hop")
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
		cmd = "HopWord",
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPre",
		setup = function()
			dofile(vim.g.base46_cache .. "rainbowdelimiters")
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
				blacklist = { "c", "cpp" },
			}
		end,
	},
	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{ "andymass/vim-matchup", event = "VeryLazy" },
	{ "vim-ruby/vim-ruby", event = "BufReadPre" },
	{
		"rcarriga/nvim-notify",
		config = function()
			dofile(vim.g.base46_cache .. "notify")
			local stages = require("notify.stages.slide")("bottom_up")
			local notify = require("notify")
			notify.setup({
				timeout = 1500,
				background_colour = "Normal",
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.75)
				end,
				on_open = function(win)
					vim.api.nvim_win_set_config(win, { zindex = 100 })
				end,
				render = "compact",
				fps = 60,

				stages = {
					function(...)
						local opts = stages[1](...)
						if opts then
							opts.border = "none"
						end
						return opts
					end,
					unpack(stages, 2),
				},
			})
			vim.notify = notify
		end,
	},
	{ "mrbjarksen/neo-tree-diagnostics.nvim", dependencies = { "nvim-neo-tree/neo-tree.nvim" }, event = "VeryLazy" },
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.keymap.set("i", "<C-h>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-l>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-j>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-k>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						fillcharhl = "",
						segments = {
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
							{
								text = { " ", builtin.foldfunc, " " },
								condition = { builtin.not_empty, true, builtin.not_empty },
								click = "v:lua.ScFa",
							},
						},
					})
				end,
			},
		},
		opts = {
			preview = {
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
			open_fold_hl_timeout = 150,
			provider_selector = function(_, filetype, buftype)
				local function handleFallbackException(bufnr, err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(bufnr, providerName)
					else
						return require("promise").reject(err)
					end
				end

				return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
					or function(bufnr)
						return require("ufo")
							.getFolds(bufnr, "lsp")
							:catch(function(err)
								return handleFallbackException(bufnr, err, "treesitter")
							end)
							:catch(function(err)
								return handleFallbackException(bufnr, err, "indent")
							end)
					end
			end,
		},
	},
	{
		"declancm/cinnamon.nvim",
		config = function()
			require("cinnamon").setup()
		end,
		event = "VeryLazy",
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		init = function()
			vim.g.neo_tree_remove_legacy_commands = true
		end,
		opts = function()
			return require("custom.configs.neotree")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		cmd = "Trouble",
		config = function()
			dofile(vim.g.base46_cache .. "trouble")
			require("trouble").setup()
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		config = function()
			require("barbecue").setup({
				create_autocmd = false,
			})
		end,
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = require("custom.configs.dashboard"),
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = require("custom.configs.gpt"),
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = {
						enabled = false,
					},
					hover = {
						enabled = false,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "BufEnter",
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}

return plugins

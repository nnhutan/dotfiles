local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
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
		end, -- Override to setup mason-lspconfig
	},

	-- override plugin configs
	{ "williamboman/mason.nvim", opts = overrides.mason },
	{ "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },
	{ "nvim-telescope/telescope.nvim", opts = overrides.telescope },
	{ "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
	{ "lewis6991/gitsigns.nvim", opts = overrides.gitsigns },
	{ "hrsh7th/nvim-cmp", opts = overrides.cmp },
	-- Install a plugin
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
			}, { prefix = "<leader>" })
		end,
	},

	{ "nvim-tree/nvim-tree.lua", enabled = false },

	{ "mg979/vim-visual-multi", event = "VeryLazy", branch = "master" },
	{ "tpope/vim-rails", lazy = false },
	{ "mattn/emmet-vim", lazy = false },
	{ "github/copilot.vim", lazy = false },
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
		lazy = false,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"rmagatti/auto-session",
		cmd = { "SaveSession", "RestoreSession" },
		config = function()
			require("auto-session").setup({
				log_level = "info",
				auto_session_enabled = true,
				auto_save_enabled = true,
				auto_restore_enabled = true,
			})
		end,
		lazy = false,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		lazy = false,
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
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			dofile(vim.g.base46_cache .. "hop")
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
		lazy = false,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
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
	{ "windwp/nvim-ts-autotag", lazy = false },
	{
		"andymass/vim-matchup",
		setup = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
		lazy = false,
	},
	{ "nvim-pack/nvim-spectre", cmd = "Spectre" },
	{ "tpope/vim-haml", event = "VeryLazy" },
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{ "thoughtbot/vim-rspec", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", event = "VeryLazy" },
	{ "vim-test/vim-test", event = "VeryLazy" },
	{ "rhysd/clever-f.vim", lazy = false },
	{ "wakatime/vim-wakatime", lazy = false },
	{
		"declancm/cinnamon.nvim",
		config = function()
			require("cinnamon").setup()
		end,
		lazy = false,
	},
	{ "vim-ruby/vim-ruby", lazy = false },
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
	{ "mrbjarksen/neo-tree-diagnostics.nvim", dependencies = { "nvim-neo-tree/neo-tree.nvim" }, lazy = false },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
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
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			dofile(vim.g.base46_cache .. "notify")
			vim.notify = require("notify")
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {},
		config = function()
			require("barbecue").setup({
				create_autocmd = false, -- prevent barbecue from updating itself automatically
			})
		end,
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
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}

return plugins

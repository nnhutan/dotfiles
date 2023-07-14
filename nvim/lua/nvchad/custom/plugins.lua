local overrides = require("custom.configs.overrides")
local icons = require("custom.icons.icons")

local get_icon = function(kind)
	return icons[kind] or ""
end

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

	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },
	--
	{ "nvim-tree/nvim-tree.lua", enabled = false },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	{ "mg979/vim-visual-multi", lazy = false },
	{ "tpope/vim-rails", lazy = false },
	{ "mattn/emmet-vim", lazy = false },
	{ "github/copilot.vim", lazy = false },
	{ "junegunn/vim-easy-align" },
	{ "folke/tokyonight.nvim" },
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
		event = { "User AstroFile", "InsertEnter" },
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
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
		lazy = false,
	},
	{ "HiPhish/nvim-ts-rainbow2", lazy = false },
	{
		"andymass/vim-matchup",
		setup = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
		lazy = false,
	},
	{ "nvim-pack/nvim-spectre", lazy = false },
	{ "tpope/vim-haml", lazy = false },
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{ "thoughtbot/vim-rspec", lazy = false },
	-- { 'dense-analysis/ale',       lazy = false },
	-- { 'sindrets/diffview.nvim',   requires = 'nvim-lua/plenary.nvim', lazy = false },
	{ "vim-test/vim-test", lazy = false },
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		init = function()
			vim.g.neo_tree_remove_legacy_commands = true
		end,
		opts = {
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			sources = { "filesystem", "buffers", "git_status" },
			source_selector = {
				winbar = true,
				content_layout = "center",
				sources = {
					{ source = "filesystem", display_name = " 󰉓  File" },
					{ source = "buffers", display_name = " 󰈙 Bufs" },
					{ source = "git_status", display_name = " 󰊢 Git" },
					{ source = "diagnostics", display_name = " 󰒡 Diagnostic" },
				},
			},
			document_symbols = {
				kinds = {
					File = { icon = "󰈙", hl = "Tag" },
					Namespace = { icon = "󰌗", hl = "Include" },
					Package = { icon = "󰏖", hl = "Label" },
					Class = { icon = "󰌗", hl = "Include" },
					Property = { icon = "󰆧", hl = "@property" },
					Enum = { icon = "󰒻", hl = "@number" },
					Function = { icon = "󰊕", hl = "Function" },
					String = { icon = "󰀬", hl = "String" },
					Number = { icon = "󰎠", hl = "Number" },
					Array = { icon = "󰅪", hl = "Type" },
					Object = { icon = "󰅩", hl = "Type" },
					Key = { icon = "󰌋", hl = "" },
					Struct = { icon = "󰌗", hl = "Type" },
					Operator = { icon = "󰆕", hl = "Operator" },
					TypeParameter = { icon = "󰊄", hl = "Type" },
					StaticMethod = { icon = "󰠄 ", hl = "Function" },
				},
			},
			default_component_configs = {
				indent = { padding = 0 },
				icon = {
					folder_closed = get_icon("FolderClosed"),
					folder_open = get_icon("FolderOpen"),
					folder_empty = get_icon("FolderEmpty"),
					folder_empty_open = get_icon("FolderEmpty"),
					default = get_icon("DefaultFile"),
				},
				modified = { symbol = get_icon("FileModified") },
				git_status = {
					symbols = {
						added = get_icon("GitAdd"),
						deleted = get_icon("GitDelete"),
						modified = get_icon("GitChange"),
						renamed = get_icon("GitRenamed"),
						untracked = get_icon("GitUntracked"),
						ignored = get_icon("GitIgnored"),
						unstaged = get_icon("GitUnstaged"),
						staged = get_icon("GitStaged"),
						conflict = get_icon("GitConflict"),
					},
				},
			},
			commands = {
				system_open = function(state)
					local path = state.tree:get_node():get_id()
					local cmd
					if vim.fn.has("win32") == 1 and vim.fn.executable("explorer") == 1 then
						cmd = { "cmd.exe", "/K", "explorer" }
					elseif vim.fn.has("unix") == 1 and vim.fn.executable("xdg-open") == 1 then
						cmd = { "xdg-open" }
					elseif (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1) and vim.fn.executable("open") == 1 then
						cmd = { "open" }
					end
					vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand("<cfile>") }), { detach = true })
				end,
				parent_or_close = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				child_or_open = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then -- if unexpanded, expand
							state.commands.toggle_node(state)
						else -- if expanded and has children, seleect the next child
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					else -- if not a directory just open it
						state.commands.open(state)
					end
				end,
				copy_selector = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						e = { val = modify(filename, ":e"), msg = "Extension only" },
						f = { val = filename, msg = "Filename" },
						F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
						h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
						p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
						P = { val = filepath, msg = "Absolute path" },
					}

					local messages = {
						{ "\nChoose to copy to clipboard:\n", "Normal" },
					}
					for i, result in pairs(results) do
						if result.val and result.val ~= "" then
							vim.list_extend(messages, {
								{ ("%s."):format(i), "Identifier" },
								{ (" %s: "):format(result.msg) },
								{ result.val, "String" },
								{ "\n" },
							})
						end
					end
					vim.api.nvim_echo(messages, false, {})
					local result = results[vim.fn.getcharstr()]
					if result and result.val and result.val ~= "" then
						vim.notify("Copied: " .. result.val)
						vim.fn.setreg("+", result.val)
					end
				end,
			},
			window = {
				width = 40,
				mappings = {
					["<space>"] = false, -- disable space until we figure out which-key disabling
					o = "open",
					O = "system_open",
					h = "parent_or_close",
					l = "child_or_open",
					Y = "copy_selector",
				},
			},
			filesystem = {
				follow_current_file = true,
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function(_)
						vim.opt_local.signcolumn = "auto"
					end,
				},
			},
		},
		lazy = false,
	},
	{
		"mickael-menu/zk-nvim",
		config = function()
			require("zk").setup({})
		end,
		lazy = false,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
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
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
		lazy = false,
	},
}

return plugins

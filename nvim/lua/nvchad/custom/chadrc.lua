local api = vim.api

local function getNeoTreeWidth()
	for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
		if vim.bo[api.nvim_win_get_buf(win)].ft == "neo-tree" then
			return api.nvim_win_get_width(win) + 1
		end
	end
	return 0
end
---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "palenight",
	theme_toggle = { "palenight", "one_light" },

	hl_override = highlights.override,
	hl_add = highlights.add,
	transparency = false,
	lsp_semantic_tokens = true,
	extended_integrations = { "hop", "rainbowdelimiters", "trouble", "notify" },

	statusline = {
		theme = "vscode_colored", -- default/vscode/vscode_colored/minimal

		-- default/round/block/arrow (separators work only for "default" statusline theme;
		-- round and block will work for the minimal theme only)
		separator_style = "round",
		overriden_modules = nil,
	},

	tabufline = {
		lazyload = true,
		overriden_modules = function(modules)
			modules[1] = (function()
				return "%#NeoTreeNormal#" .. string.rep(" ", getNeoTreeWidth())
			end)()
		end,
	},
	nvdash = {

		header = {
			"                                                   ",
			"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                   ",
		},

		buttons = {
			{ "  Find File", "Spc f f", "Telescope find_files" },
			{ "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
			{ "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
			{ "  Bookmarks", "Spc m a", "Telescope marks" },
			{ "  Themes", "Spc t h", "Telescope themes" },
			{ "  Mappings", "Spc c h", "NvCheatsheet" },
		},
	},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = false,
	update_in_insert = false,
})

return M

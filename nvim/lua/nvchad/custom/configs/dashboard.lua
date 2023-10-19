return function()
	require("dashboard").setup({
		theme = "doom",
		disable_move = true,
		preview = {
			command = "cat | cat",
			file_path = "~/.config/nvim/lua/custom/logo.cat",
			file_height = 12,
			file_width = 71,
		},
		hide = {
			-- statusline = true,
			tabline = false,
		},
		config = {
			center = {
				{
					icon = "󰈚  ",
					icon_hl = "String",
					desc = "Find File                         ",
					desc_hl = "String",
					key = "f",
					key_hl = "Number",
					keymap = "SPC f f",
					action = "Telescope find_files",
				},
				{
					icon = "󰈭  ",
					icon_hl = "String",
					desc = "Find Word                         ",
					desc_hl = "String",
					key = "w",
					key_hl = "Number",
					keymap = "SPC f w",
					action = "Telescope live_grep",
				},
				{
					icon = "  ",
					icon_hl = "String",
					desc = "Themes                            ",
					desc_hl = "String",
					key = "t",
					key_hl = "Number",
					keymap = "SPC f t",
					action = "Telescope themes",
				},
				{
					icon = "  ",
					icon_hl = "String",
					desc = "Mappings                          ",
					desc_hl = "String",
					key = "m",
					key_hl = "Number",
					keymap = "SPC f m",
					action = "NvCheatsheet",
				},
				{
					icon = "  ",
					icon_hl = "String",
					desc = "Settings                          ",
					desc_hl = "String",
					key = "s",
					key_hl = "Number",
					keymap = "",
					action = "e ~/.config/nvim/",
				},
			},
			footer = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return {
					"🎉 Have fun with Neovim!",
					"",
					"🚀 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
					"",
					"",
					"",
					"💎 Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
				}
			end,
		},
	})
	vim.cmd("highlight dashboardFooter guifg='#efefe1'")
end

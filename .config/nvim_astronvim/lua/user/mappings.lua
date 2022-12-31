-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local mappings = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bb"] = { "<cmd>Neotree buffers<cr>", desc = "Toggle explorer buffers" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    ["<leader>bd"] = { "<cmd>bufdo Bwipeout<cr>", desc = "Close all" },
    ["<leader>bp"] = { "<cmd>let @+ = expand('%:p')<cr>", desc = "Copy path" },
    ["<leader>bh"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
    ["<leader>bl"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
    ["<leader>ss"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" },
    ["<leader>ms"] = { "<cmd>MarkdownPreview<cr>", desc = "Start markdown preview" },
    ["<leader>me"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Stop markdown preview" },
    ["<leader>a"] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },
    ["<leader>j"] = { "<cmd>HopWord<cr>", desc = "Jump to word" },
    ["<leader>k"] = { "<cmd>TagbarOpenAutoClose<cr>", desc = "Show tagbar" },
    ["<leader>ll"] = { "<cmd>LspRestart<cr>", desc = "Reload workspace" },
    ["<leader>ue"] = { "<cmd>Telescope colorscheme<cr>", desc = "Explore colorschemes" },
    --[[ ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle explore" }, ]]
    --[[ ["<leader>e"] = { "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle explore" }, ]]
    --[[ ["<leader>o"] = { "<cmd>NvimTreeFocus<cr>", desc = "Focus of explore" }, ]]
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    --[[ ["<C-t"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" }, ]]
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
  i = {
    ["<C-e>"] = { "copilot#Accept('<CR>')", silent = true, expr = true },
    -- vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    --[[ ["<C-t"] = { "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>" }, ]]
  },
}

return mappings

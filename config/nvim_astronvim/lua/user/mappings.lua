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
    ["<leader>bp"] = { "<cmd>let @+ = expand('%')<cr>", desc = "Copy relative path" },
    ["<leader>bP"] = { "<cmd>let @+ = expand('%:p')<cr>", desc = "Copy absolute path" },
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
    ["<leader>H"] = { "<cmd>nohlsearch<cr>", desc = "No Highlight" }, -- TODO: REMOVE IN v3
    ["<leader>h"] = { "<cmd>Copilot<cr>", desc = "Copilot hints" }, -- TODO: REMOVE IN v3

    ["gpd"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>" },
    ["gpt"] = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>" },
    ["gpi"] = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>" },
    ["gP"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>" },
    ["gpr"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>" },
    --[[ ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle explore" }, ]]
    --[[ ["<leader>e"] = { "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle explore" }, ]]
    --[[ ["<leader>o"] = { "<cmd>NvimTreeFocus<cr>", desc = "Focus of explore" }, ]]
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    --[[ ["<C-t"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" }, ]]
    ["<Leader>L"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      silent = true,
      noremap = true,
      desc = "toggle signature",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
  i = {
    ["<C-l>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false, noremap = true },
    ["<C-h>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false, nowait = true },
    ["<C-e>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false },
  },
}

return mappings
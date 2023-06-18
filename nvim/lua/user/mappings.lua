function FuzzyFindFiles()
  local input_string = vim.fn.input("Search For > ")
  if (input_string == '') then
    return
  end
  require('telescope.builtin').grep_string({ search = input_string })
end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer"
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer"
    },
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>a"] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },
    ["<leader>c"] = {
      function()
        local bufs = vim.fn.getbufinfo { buflisted = true }
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
      end,
      desc = "Close buffer",
    },
    ["<leader>j"] = { "<cmd>HopWord<cr>", desc = "Jump to word" },
    ["<leader>s"] = { name = "Spectre" },
    ["<leader>ss"] = { '<cmd>lua require("spectre").open()<CR>', desc = "Open Spectre" },
    ["<leader>sw"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word" },
    ["<leader>sp"] = { '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc =
    "Search on current file" },
    ["<leader>fs"] = { "<cmd>lua FuzzyFindFiles{}<CR>", desc = "Grep string" },
    ["<leader>e"] = { "<cmd>Neotree toggle filesystem<CR>", desc = "Toggle Explorer" },
    ["<leader>o"] = { "<cmd>Neotree focus filesystem<CR>", desc = "Toggle Focus Explorer" },
    ["<leader>T"] = { name = "Test" },
    ["<leader>Tf"] = { "<cmd>TestFile -strategy=neovim<CR>", desc = "Test file" },
    ["<leader>Tn"] = { "<cmd>TestNearest<CR>", desc = "Test nearest" },
    ["<leader>Tc"] = { "<cmd>TestClass<CR>", desc = "Test class" },
    ["<leader>Ts"] = { "<cmd>TestSuite<CR>", desc = "Test suite" },
  },
  i = {
    ["<C-e>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false, noremap = true },
    ["<C-h>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false, noremap = true },
    ["<C-j>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false, noremap = true },
    ["<C-l>"] = { "copilot#Accept('<CR>')", silent = true, expr = true, replace_keycodes = false, noremap = true },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["<leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" },
  }
}

local map = vim.keymap.set
map("n", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" })
map("n", "]t", "<cmd> tabnext <CR>", { desc = "Next tabs group" })
map("n", "[t", "<cmd> tabprevious <CR>", { desc = "Prev tabs group" })
map("n", ";", ":", { desc = "enter command mode", nowait = true })
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })
map("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
map("n", "<leader>w", "<cmd> w <CR>", { desc = "Save file" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
map("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "L", "<cmd>bnext<CR>", { desc = "Goto next buffer" })
map("n", "H", "<cmd>bprevious<CR>", { desc = "Goto prev buffer" })
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Find words" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
map("n", "<leader>fN", "<cmd> Telescope notify <CR>", { desc = "Notifications" })
map("n", "<leader>ft", "<cmd> Telescope colorscheme <CR>", { desc = "Theme" })
map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })
map("n", "<leader>gg", "<cmd> LazyGit <CR>", { desc = "LazyGit" })
map("n", "<leader>fa", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })
map("n", "<leader>fp", "<cmd>lua require('utils').CopyFilePath('p')<CR>", { desc = "Path relative to CWD" })
map("n", "<leader>fh", "<cmd>lua require('utils').CopyFilePath('h')<CR>", { desc = "Path relative to Home" })
map("n", "<leader>fP", "<cmd>lua require('utils').CopyFilePath('P')<CR>", { desc = "Absolute path" })
map("n", "<leader>fe", "<cmd>lua require('utils').CopyFilePath('e')<CR>", { desc = "Extension only" })
map("n", "<leader>fn", "<cmd>lua require('utils').CopyFilePath('f')<CR>", { desc = "Filename" })
map("n", "<leader>Ss", '<cmd>lua require("persistence").load()<cr>', { desc = "Load current session" })
map("n", "<leader>a", '<cmd>lua require("persistence").load()<cr>', { desc = "Load current session" })
map("n", "<leader>Sl", '<cmd>lua require("persistence").load({ last = true })<cr>', { desc = "Load last session" })
map("n", "<leader>Sq", '<cmd>lua require("persistence").stop()<cr>', { desc = "Stop persistence" })
map("n", "<leader>gD", "<cmd>wincmd p | q<cr>", { desc = "Close git diff" })
map("n", "<leader>j", "<cmd>HopWord<cr>", { desc = "Jump to word" })
map("n", "<leader>s", "<cmd>Spectre<cr>", { desc = "Search panel" })
map("n", "<leader>lt", "<cmd>Trouble<cr>", { desc = "Code problems" })
map("n", "<leader>G", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
map("n", "<leader>kc", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
map("n", "<leader>ke", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
map("n", "<leader>kg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
map("n", "<leader>kt", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
map("n", "<leader>kk", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
map("n", "<leader>kd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
map("n", "<leader>ka", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
map("n", "<leader>ko", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
map("n", "<leader>ks", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
map("n", "<leader>kf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
map("n", "<leader>kx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
map("n", "<leader>kr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
map("n", "<leader>kl", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })
map("n", '<leader>tn', '<cmd>lua require(ntest).run.run()<cr>', { desc = "Nearest" })
map("n", '<leader>tf', '<cmd>lua require(ntest).run.run(vim.fn.expand("%"))<cr>', { desc = "File" })
map("n", '<leader>tS', '<cmd>lua require(ntest).run.stop()<cr>', { desc = "Stop" })
map("n", '<leader>tp', '<cmd>lua require(ntest).output_panel.toggle()<cr>', { desc = "Result panel" })
map("n", '<leader>tx', '<cmd>lua require(ntest).output_panel.clear()<cr>', { desc = "Clear result panel" })
map("n", '<leader>to', '<cmd>lua require(ntest).output.open({ enter = true }) <cr>', { desc = "Result" })
map("n", '<leader>ts', '<cmd>lua require(ntest).summary.toggle()<cr>', { desc = "Summary" })
map("n", '<leader>tw', '<cmd>lua require(ntest).watch.toggle(vim.fn.expand("%"))<cr>', { desc = "Watch" })
map("n", "<leader>bC", function()
  local bufs = vim.api.nvim_list_bufs()
  for _, i in ipairs(bufs) do
    require("mini.bufremove").delete(i)
  end
end
, { desc = "Close all buffers", })
map("n", "<leader>bc", function()
  local bufs = vim.api.nvim_list_bufs()
  local current = vim.fn.bufnr()
  for _, i in ipairs(bufs) do
    if i ~= current then
      require("mini.bufremove").delete(i)
    end
  end
end
, { desc = "Close all buffers except current" })
map("n", "<leader>c", function()
  local bd = require("mini.bufremove").delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end, { desc = "Delete Buffer" })

map("n", "<leader>lf", function()
    vim.lsp.buf.format { async = true }
  end,
  { desc = "LSP formatting", })
map("n", "<leader>ld", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Floating diagnostic", })
map("n", "<leader>ls", function()
  -- require("telescope.builtin").lsp_document_symbols()
  local aerial_avail, _ = pcall(require, "aerial")
  if aerial_avail then
    require("telescope").extensions.aerial.aerial()
  else
    require("telescope.builtin").lsp_document_symbols()
  end
end, { desc = "Search document symbols", })
map("n", "<leader>lw", function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "Search workspace symbols", })
map("n", "<leader>lS", function()
  require("aerial").toggle()
end, { desc = "Symbols outline", })
map("n", "<leader>fF", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find files (all)", })
map("n", "<leader>fW", function()
  require("telescope.builtin").live_grep({
    additional_args = function(args)
      return vim.list_extend(args, { "--hidden", "--no-ignore" })
    end,
  })
end, { desc = "Find words (all)", })
map("n", "<leader>fs", function() require("utils").FuzzyFindFiles() end, { desc = "Grep string", })
map("n", "]g", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to next hunk", expr = true })
map("n", "[g", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to prev hunk", expr = true })
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
map("n", "<leader>gl", function() package.loaded.gitsigns.blame_line() end, { desc = "Blame line" })
map("n", "<leader>gd", function() require("gitsigns").diffthis() end, { desc = "Git diff" })
map("n", "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, { desc = "Dismiss all Notifications" })
map("n", "<leader>ut", function()
  local current_theme = vim.g.colors_name
  -- catppuccin-*
  if current_theme:match("^catppuccin") then
    local palette = current_theme:match("^catppuccin%-([^-]+)")
    if palette == "latte" then
      palette = 'mocha'
    else
      palette = 'latte'
    end

    vim.cmd("colorscheme catppuccin-" .. palette)
    os.execute("tmux set -g @catppuccin_flavour '" .. palette .. "' && tmux source-file ~/.tmux.conf")
    -- store the palette in the env
    vim.env.CATPPUCCINO_FLAVOUR = palette
  end
end)

map("v", "<c-t>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal" })
map("v", "<c-b>w", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal" })
map("v", "<leader>ke", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
map("v", "<leader>kg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
map("v", "<leader>kt", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
map("v", "<leader>kk", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
map("v", "<leader>kd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
map("v", "<leader>ka", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
map("v", "<leader>ko", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
map("v", "<leader>ks", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
map("v", "<leader>kf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
map("v", "<leader>kx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
map("v", "<leader>kr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
map("v", "<leader>kl", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })
map("v", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("v", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("v", "<", "<gv", { desc = "Indent line" })
map("v", ">", ">gv", { desc = "Indent line" })

map("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

map("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })


map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-h>", function() require("copilot.suggestion").accept() end, { desc = "Copilot accept" })

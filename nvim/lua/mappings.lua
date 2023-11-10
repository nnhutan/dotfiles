local load_keymap = require('utils').load_keymap

local key_maps = {
  n = {
    ["]t"] = { "<cmd> tabnext <CR>", "Next tabs group" },
    ["[t"] = { "<cmd> tabprevious <CR>", "Prev tabs group" },
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    -- split
    ["|"] = { "<cmd>vsplit<cr>", "Vertical Split" },
    ["\\"] = { "<cmd>split<cr>", "Horizontal Split" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    ["<leader>w"] = { "<cmd> w <CR>", "Save file" },

    -- resize
    ["<C-Up>"] = { "<cmd>resize -2<CR>", "Resize split up" },
    ["<C-Down>"] = { "<cmd>resize +2<CR>", "Resize split down" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Resize split left" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Resize split right" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- Quit
    ["<leader>q"] = { "<cmd>q<cr>", "Quit" },
    ["<leader>Q"] = { "<cmd>qa<cr>", "Quit all" },

    -- number
    ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- improve motion
    -- ["j"] = { "v:count == 0 ? 'gj' : 'j'", "Move down", opts = { expr = true, silent = true } },
    -- ["k"] = { "v:count == 0 ? 'gk' : 'k'", "Move up", opts = { expr = true, silent = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- bufferline
    ["L"] = { "<cmd>BufferLineCycleNext<CR>", "Goto next buffer", },
    ["H"] = { "<cmd>BufferLineCyclePrev<CR>", "Goto prev buffer", },
    ["<leader>bC"] = {
      function()
        for _, e in ipairs(require('bufferline').get_elements().elements) do
          vim.schedule(function()
            vim.cmd("bd " .. e.id)
          end)
        end
      end,
      "Close all buffers",
    },

    ["<leader>bc"] = { "<cmd>BufferLineCloseOthers<CR>", "Close all buffers except current", },
    ["<leader>c"] = { "<cmd>close<CR>", "Close buffer", },
    ["<leader>c"] = {
      function()
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
      end,
      "Delete Buffer",
    },

    -- nvimtree
    ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle nvimtree" },
    ["<leader>o"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },

    -- lsp
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
    ["<leader>ld"] = {
      function()
        vim.diagnostic.open_float({ border = "rounded" })
      end,
      "Floating diagnostic",
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

    -- telescope
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
    ["<leader>fs"] = { function() require("utils").FuzzyFindFiles() end, "Grep string" },
    ["<leader>fN"] = { "<cmd> Telescope notify <CR>", "Notifications" },

    -- git
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>ft"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>fa"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },


    ["<leader>fp"] = { "<cmd>lua require('utils').CopyFilePath('p')<CR>", "Path relative to CWD" },
    ["<leader>fh"] = { "<cmd>lua require('utils').CopyFilePath('h')<CR>", "Path relative to Home" },
    ["<leader>fP"] = { "<cmd>lua require('utils').CopyFilePath('P')<CR>", "Absolute path" },
    ["<leader>fe"] = { "<cmd>lua require('utils').CopyFilePath('e')<CR>", "Extension only" },
    ["<leader>fn"] = { "<cmd>lua require('utils').CopyFilePath('f')<CR>", "Filename" },

    -- git sign
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
    ["<leader>gD"] = { "<cmd>wincmd p | q<cr>", "Close git diff" },

    ["<leader>j"] = { "<cmd>HopWord<cr>", "Jump to word" },
    ["<leader>Tf"] = { "<cmd>TestFile -strategy=neovim<CR>", "Test file" },
    ["<leader>Tn"] = { "<cmd>TestNearest<CR>", "Test nearest" },
    ["<leader>Tc"] = { "<cmd>TestClass<CR>", "Test class" },
    ["<leader>Ts"] = { "<cmd>TestSuite<CR>", "Test suite" },
    ["<leader>s"] = { "<cmd>Spectre<cr>", "Search panel" },

    ["<leader>lt"] = { "<cmd>Trouble<cr>", "Code problems" },

    -- persistent
    ["<leader>Ss"] = { '<cmd>lua require("persistence").load()<cr>', "Load current session" },
    ["<leader>a"] = { '<cmd>lua require("persistence").load()<cr>', "Load current session" },
    ["<leader>Sl"] = { '<cmd>lua require("persistence").load({ last = true })<cr>', "Load last session" },
    ["<leader>Sq"] = { '<cmd>lua require("persistence").stop()<cr>', "Stop persistence" },

    --notify
    ["<leader>un"] = {
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      "Dismiss all Notifications",
    },

    -- GPT

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
    -- gpt
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

    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
  },
  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },
  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },
    ["<C-h>"] = {
      function()
        require("copilot.suggestion").accept()
      end,
      "Copilot accept",
      opts = {},
    },
  },
}

load_keymap(key_maps)

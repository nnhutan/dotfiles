function FuzzyFindFiles()
  local input_string = vim.fn.input "Search For > "
  if input_string == "" then
    return
  end
  require("telescope.builtin").grep_string { search = input_string }
end

---@type MappingsTable
local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    ["<C-l>"] = {
      'copilot#Accept("<CR>")',
      "Copilot accept",
      opts = { silent = true, expr = true, replace_keycodes = false },
    },
    ["<C-k>"] = {
      'copilot#Accept("<CR>")',
      "Copilot accept",
      opts = { silent = true, expr = true, replace_keycodes = false },
    },
    ["<C-j>"] = {
      'copilot#Accept("<CR>")',
      "Copilot accept",
      opts = { silent = true, expr = true, replace_keycodes = false },
    },
    ["<C-h>"] = {
      'copilot#Accept("<CR>")',
      "Copilot accept",
      opts = { silent = true, expr = true, replace_keycodes = false },
    },

    -- navigate within insert mode
    -- ["<C-h>"] = { "<Left>", "Move left" },
    -- ["<C-l>"] = { "<Right>", "Move right" },
    -- ["<C-j>"] = { "<Down>", "Move down" },
    -- ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["]t"] = { "<cmd> tabNext <CR>", "Next tabs group" },
    ["[t"] = { "<cmd> tabprevious <CR>", "Prev tabs group" },

    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>w"] = { "<cmd> w <CR>", "Save file" },
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
    ["<leader>q"] = { "<cmd> q <CR>", "Quit" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    ["<leader>fm"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
    -- split
    ["|"] = { "<cmd>vsplit<cr>", "Vertical Split" },
    ["\\"] = { "<cmd>split<cr>", "Horizontal Split" },
    -- resize
    ["<C-Up>"] = { "<cmd>resize -2<CR>", "Resize split up" },
    ["<C-Down>"] = { "<cmd>resize +2<CR>", "Resize split down" },
    ["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Resize split left" },
    ["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Resize split right" },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<S-Tab>"] = { "<gv", "Unindent line" },
    ["<Tab>"] = { ">gv", "Indent line" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["L"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["H"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>c"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "Close buffer",
    },

    ["<leader>bn"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>bc"] = {
      function()
        require("nvchad_ui.tabufline").closeOtherBufs()
      end,
      "Close all buffers except current",
    },
    ["<leader>bC"] = {
      function()
        require("nvchad_ui.tabufline").closeAllBufs()
      end,
      "Close all buffers",
    },
    ["<leader>bh"] = {
      function()
        require("nvchad_ui.tabufline").move_buf(-1)
      end,
      "Move left",
    },
    ["<leader>bl"] = {
      function()
        require("nvchad_ui.tabufline").move_buf(1)
      end,
      "Move right",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>lh"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>ld"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
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
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fF"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find files (all)" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Find words" },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
        }
      end,
      "Find words (all)",
    },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fs"] = { "<cmd>lua FuzzyFindFiles{}<CR>", "Grep string" },

    -- git
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>ft"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>fa"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },

    -- new
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "New horizontal term",
    },

    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "New vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,
}

M.blankline = {
  plugin = true,

  n = {},
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
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
  },
}

M.hop = {
  n = {
    ["<leader>j"] = { "<cmd>HopWord<cr>", "Jump to word" },
  },
}
require("core.utils").load_mappings "hop"

M.test = {
  n = {
    ["<leader>Tf"] = { "<cmd>TestFile -strategy=neovim<CR>", "Test file" },
    ["<leader>Tn"] = { "<cmd>TestNearest<CR>", "Test nearest" },
    ["<leader>Tc"] = { "<cmd>TestClass<CR>", "Test class" },
    ["<leader>Ts"] = { "<cmd>TestSuite<CR>", "Test suite" },
  },
}
require("core.utils").load_mappings "test"

M.neotree = {
  plugin = true,

  n = {
    ["<leader>e"] = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
    ["<leader>o"] = {
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.Neotree "focus"
        end
      end,
      "Toggle Explorer Focus",
    },
  },
}
require("core.utils").load_mappings "neotree"

M.disabled = {
  n = {
    ["<leader>wK"] = "",
    ["<leader>wk"] = "",
    ["<leader>cc"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>ca"] = "",
    ["<leader>q"] = "",
    ["<leader>b"] = "",
    ["]c"] = "",
    ["[c"] = "",
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",
    ["<leader>td"] = "",
    ["<leader>fa"] = "",
    ["<leader>fm"] = "",
    ["<leader>ra"] = "",
    ["<C-n>"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>ch"] = "",
    ["<leader>th"] = "",
    ["<leader>cm"] = "",
    ["<leader>ma"] = "",
    ["<leader>f"] = "",
    ["<leader>e"] = "",
    ["<leader>o"] = "",
  },
}

return M

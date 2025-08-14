return {
  { "nvim-lua/plenary.nvim",      lazy = true, },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>s",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  { "echasnovski/mini.bufremove", event = "BufReadPre" },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          -- Defaults
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = false -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ["html"] = {
            enable_close = false
          }
        }
      })
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPre",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'scrolloff' }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 150
    end,
  },
  -- { "mattn/emmet-vim",          event = "VeryLazy" },
  { "rhysd/clever-f.vim",       event = "VeryLazy" },
  { "mg979/vim-visual-multi",   event = "VeryLazy",    branch = "master" },
  { 'vidocqh/auto-indent.nvim', event = "InsertEnter", opts = {}, },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        timeout = vim.o.timeoutlen,
        default_mappings = false,
        mappings = {
          i = {
            j = {
              -- These can all also be functions
              k = "<Esc>",
              j = "<Esc>",
            },
          },
          c = {
            j = {
              k = "<Esc>",
              j = "<Esc>",
            },
          },
          t = {
            j = {
              k = "<C-\\><C-n>",
            },
          },
          v = {
            j = {},
            k = {},
          },
          s = {
            j = {
              k = "<Esc>",
            },
          },
        },
      }
    end,
  },
  {
    "declancm/cinnamon.nvim",
    event = "VeryLazy",
    config = function()
      require("cinnamon").setup {
        -- Enable all provided keymaps
        keymaps = {
          basic = true,
          extra = false,
        },
        options = {
          -- mode = "window",
          -- delay = 1,
          max_delta = {
            -- Maximum distance for line movements before scroll
            -- animation is skipped. Set to `false` to disable
            line = 100,
            -- Maximum distance for column movements before scroll
            -- animation is skipped. Set to `false` to disable
            column = false,
            -- Maximum duration for a movement (in ms). Automatically scales the
            -- delay and step size
            time = 1000,
          },
        },
      }
    end,
  },
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = function()
      require("scope").setup({})
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = { user_default_options = { names = false } },
  },
  {
    "kylechui/nvim-surround",
    event = "BufReadPre",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPre",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { "kdheepak/lazygit.nvim",     cmd = "LazyGit", },
  { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" }, event = "BufReadPre", },
  { "folke/persistence.nvim",    opts = {} },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    keys = {
      { "<leader>bp", "<cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>bP", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Pictures",
      has_breadcrumbs = true,
      has_line_number = true,
    },
  },
  { "tpope/vim-dotenv",        event = "BufReadPre", },
  { 'tpope/vim-projectionist', lazy = false },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup({
        -- configurations go here
        create_autocmd = false,
      })
      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
  -- {
  --   "LunarVim/bigfile.nvim",
  --   lazy = false,
  -- },
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<c-h>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-j>",
  --       },
  --     })
  --   end,
  -- }
}

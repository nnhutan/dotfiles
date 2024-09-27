return {
  { "nvim-lua/plenary.nvim",      lazy = true, },
  -- { "wakatime/vim-wakatime",      lazy = false },
  { "nvim-pack/nvim-spectre",     cmd = "Spectre" },
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
  -- { "sindrets/diffview.nvim",     event = "VeryLazy" },
  -- { "mattn/emmet-vim",          event = "VeryLazy" },
  { "rhysd/clever-f.vim",       event = "VeryLazy" },
  { "mg979/vim-visual-multi",   event = "VeryLazy",    branch = "master" },
  { 'vidocqh/auto-indent.nvim', event = "InsertEnter", opts = {}, },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
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
        -- options = { mode = "window" },
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
  -- { 'Bekaboo/dropbar.nvim',    dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' } },
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
    -- opts = {
    --   -- configurations go here
    --   create_autocmd = false,
    -- },
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
  --   "tris203/precognition.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {}
  -- },
  {
    "LunarVim/bigfile.nvim",
    lazy = false,
  }
}

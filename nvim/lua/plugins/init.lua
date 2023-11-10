local configs = require("plugins.configs")
local plugins = {
  { "nvim-lua/plenary.nvim",               lazy = true, },
  { "wakatime/vim-wakatime",               lazy = false },
  { "nvim-pack/nvim-spectre",              cmd = "Spectre" },
  { "echasnovski/mini.bufremove",          event = "BufReadPre" },
  { "windwp/nvim-ts-autotag",              event = "VeryLazy" },
  { "andymass/vim-matchup",                event = "VeryLazy" },
  { "vim-ruby/vim-ruby",                   event = "BufReadPre" },
  { "tpope/vim-haml",                      event = "VeryLazy" },
  { "thoughtbot/vim-rspec",                event = "VeryLazy" },
  { "sindrets/diffview.nvim",              event = "VeryLazy" },
  { "vim-test/vim-test",                   event = "VeryLazy" },
  { "tpope/vim-rails",                     event = "VeryLazy" },
  { "mattn/emmet-vim",                     event = "VeryLazy" },
  { "rhysd/clever-f.vim",                  event = "VeryLazy" },
  { "nvim-tree/nvim-web-devicons",         config = configs.devicon },
  { "lukas-reineke/indent-blankline.nvim", event = { "BufReadPre", "BufNewFile" }, config = configs.blankline, },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    config = configs.neogit
  },
  { "mg979/vim-visual-multi",          event = "VeryLazy",        branch = "master" },
  { "folke/persistence.nvim",          event = "BufReadPre",      opts = {} },
  { "lewis6991/gitsigns.nvim",         config = configs.gitsign,  event = { "BufReadPre", "BufNewFile" }, },
  { "nvim-tree/nvim-tree.lua",         config = configs.nvimtree, cmd = { "NvimTreeToggle", "NvimTreeFocus" }, },
  { 'stevearc/dressing.nvim',          opts = {},                 config = configs.dressing },
  { "rcarriga/nvim-notify",            event = "VeryLazy",        config = configs.notify },
  { "stevearc/conform.nvim",           lazy = true,               config = configs.conform },
  { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre",      config = configs.rainbow },
  { "akinsho/bufferline.nvim",         event = "BufReadPre",      config = configs.bufferline },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  { "numToStr/Comment.nvim",  event = "BufReadPre", config = function() require("Comment").setup() end, },
  {
    "kylechui/nvim-surround",
    event = "BufReadPre",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  { "declancm/cinnamon.nvim", event = "VeryLazy",   config = function() require("cinnamon").setup() end, },
  { "tiagovla/scope.nvim",    event = "VeryLazy",   config = function() require("scope").setup({}) end },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = { user_default_options = { names = false } },
  },
  { "neovim/nvim-lspconfig", config = configs.lspconfig, event = { "BufReadPre", "BufNewFile" }, },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  { "phaazon/hop.nvim",      branch = "v2",              cmd = "HopWord",                        config = configs.hop, },
  { "folke/flash.nvim",      event = "VeryLazy",         opts = {},                              keys = configs.flash },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = configs
        .copilot
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPre",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim" }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = configs
        .catppuccin
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = configs.lualine,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    config = function() require("trouble").setup() end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = configs.cmp.dependencies,
    config = configs.cmp.config
  },
  {
    "glepnir/dashboard-nvim",
    config = configs.dashboard,
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "BufReadPost",
    config = configs.copilot_status,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = configs.gpt,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = configs.noice
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g", "y", "\\" },
    cmd = "WhichKey",
    config = configs.whichkey,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function() require("mason").setup() end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    cmd = "Telescope",
    config = configs.telescope
  },
  { 'vidocqh/auto-indent.nvim', event = "InsertEnter", opts = {}, },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
    },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,
    config = configs.treesitter
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = configs.octo,
  }
}

require("lazy").setup(plugins, configs.lazy)

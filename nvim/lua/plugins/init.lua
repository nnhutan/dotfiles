return {
  { "nvim-lua/plenary.nvim",      lazy = true, },
  { "wakatime/vim-wakatime",      lazy = false },
  { "nvim-pack/nvim-spectre",     cmd = "Spectre" },
  { "echasnovski/mini.bufremove", event = "BufReadPre" },
  { "windwp/nvim-ts-autotag",     event = "VeryLazy" },
  { "andymass/vim-matchup",       event = "VeryLazy" },
  { "vim-ruby/vim-ruby",          event = "BufReadPre" },
  { "tpope/vim-haml",             event = "VeryLazy" },
  { "thoughtbot/vim-rspec",       event = "VeryLazy" },
  { "sindrets/diffview.nvim",     event = "VeryLazy" },
  { "tpope/vim-rails",            event = "VeryLazy" },
  { "mattn/emmet-vim",            event = "VeryLazy" },
  { "rhysd/clever-f.vim",         event = "VeryLazy" },
  { "mg979/vim-visual-multi",     event = "VeryLazy",    branch = "master" },
  { 'vidocqh/auto-indent.nvim',   event = "InsertEnter", opts = {}, },
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
      require("cinnamon").setup()
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
}

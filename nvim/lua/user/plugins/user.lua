return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup({ toggle_key = "<C-x>" })
    end,
  },
  { "tpope/vim-rails",        lazy = false },
  { "mattn/emmet-vim",        lazy = false },
  { "github/copilot.vim",     lazy = false },
  { "mg979/vim-visual-multi", lazy = false },
  { "junegunn/vim-easy-align" },
  { "folke/tokyonight.nvim" },
  { "kylechui/nvim-surround", config = function() require("nvim-surround").setup {} end, lazy = false },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end,
    lazy = false
  },
  { "HiPhish/nvim-ts-rainbow2", lazy = false },
  {
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    lazy = false
  },
  { 'nvim-pack/nvim-spectre',   lazy = false },
  { 'tpope/vim-haml',           lazy = false },
  { "ellisonleao/glow.nvim",    config = true,                      cmd = "Glow" },
  { 'thoughtbot/vim-rspec',     lazy = false },
  -- { 'dense-analysis/ale',       lazy = false },
  { 'sindrets/diffview.nvim',   requires = 'nvim-lua/plenary.nvim', lazy = false },
  { 'vim-test/vim-test',        lazy = false },
  { 'rhysd/clever-f.vim',       lazy = false },
  {
    "sainnhe/sonokai",
    init = function() -- init function runs before the plugin is loaded
      vim.g.sonokai_style = "shusia"
    end,
  },
  {
    "shaunsingh/nord.nvim"
  },
  { "marko-cerovac/material.nvim" }
  -- { "catppuccin/nvim",          name = "catppuccin",                lazy = false }
  -- {
  --   'Exafunction/codeium.vim',
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true })
  --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
  --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  --   end
  --   ,
  --   lazy = false
  -- }
  --
}

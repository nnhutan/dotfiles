local catppuccin = require("user.plugins.catppuccin")
local nightfox = require("user.plugins.nightfox")
local lualine = require("user.plugins.lualine")
local markdown_preview = require("user.plugins.markdown_preview")
local nvim_surround = require("user.plugins.nvim_surround")
local hop = require("user.plugins.hop")
local lsp_signature = require("user.plugins.lsp_signature")
-- local material = require "user.plugins.material"
local init = {
  -- You can disable default plugins: ["plugin_name"] = { disable = true },
  ["feline-nvim/feline.nvi"] = { disable = true },
  ["rebelot/heirline.nvim"] = { disable = true },
  -- You can also add new plugins here as well:
  { "tpope/vim-rails" },
  { "mattn/emmet-vim" },
  { "rafamadriz/neon" },
  { "preservim/tagbar" },
  {
    "github/copilot.vim",
    config = function()
      astronvim.add_cmp_source({ name = "copilot", priority = 1000 })
    end,
  },
  { "thoughtbot/vim-rspec" },
  { "folke/tokyonight.nvim" },
  { "mg979/vim-visual-multi" },
  { "junegunn/vim-easy-align" },
  { "shaunsingh/moonlight.nvim" },
  { "arkav/lualine-lsp-progress" },
  { "bluz71/vim-nightfly-guicolors" },
  { "EdenEast/nightfox.nvim",       config = nightfox },
  { "phaazon/hop.nvim",             branch = "v2",         config = hop },
  { "kylechui/nvim-surround",       config = nvim_surround },
  { "catppuccin/nvim",              as = "catppuccin",     config = catppuccin },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = lsp_signature,
  },
  { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true }, config = lualine },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = markdown_preview,
    ft = { "markdown" },
  },
  -- { "marko-cerovac/material.nvim", config = material },
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({})
    end,
  },
  { "mfussenegger/nvim-jdtls" },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false },
  --     })
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --     astronvim.add_cmp_source({ name = "copilot", priority = 1000 })
  --   end,
  -- },
  { "edluffy/hologram.nvim" },
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
}

return init

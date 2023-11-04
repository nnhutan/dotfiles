local plugins = {
  { lazy = true,                   "nvim-lua/plenary.nvim" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = require('plugins.configs.catppuccin')
  },
  { "nvim-tree/nvim-web-devicons", config = function() require("nvim-web-devicons").setup({}) end, },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function(_, opts)
      require "plugins.configs.nvimtree"
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",

      -- snippets
      --list of default snippets
      "rafamadriz/friendly-snippets",

      -- snippets engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },

      -- autopairs , autocompletes ()[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()

          --  cmp integration
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          local cmp = require "cmp"
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
    },
    config = function()
      require "plugins.configs.cmp"
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("BeLazyOnFileOpenLSP", {}),
        callback = function()
          local file = vim.fn.expand "%"
          local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

          if condition then
            vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpenLSP")

            -- dont defer for treesitter as it will show slow highlighting
            -- This deferring only happens only when we do "nvim filename"
            vim.schedule(function()
              require("lazy").load { plugins = 'nvim-lspconfig' }
              vim.cmd "silent! do FileType"
            end, 0)
          end
        end,
      })
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.blankline"),
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = require("plugins.configs.gitsign"),
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    config = function()
      require "plugins.configs.bufferline"
    end,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>c",
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
        desc = "Delete Buffer",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = require 'plugins.configs.lualine'
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local stages = require "notify.stages.slide" "bottom_up"
      local notify = require "notify"
      if not unpack then
        unpack = table.unpack
      end
      notify.setup {
        timeout = 1500,
        background_colour = "Normal",
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
        render = "compact",
        fps = 60,

        stages = {
          function(...)
            local opts = stages[1](...)
            if opts then
              opts.border = "none"
            end
            return opts
          end,
          unpack(stages, 2),
        },
      }
      vim.notify = notify
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = require("plugins.configs.noice"),
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = {},
    config = function()
      require("dressing").setup({
        input = {
          prompt_align = "center",
          win_options = {
            winhighlight =
            "FloatNormal:TelescopePreviewNormal,FloatBorder:TelescopePreviewBorder,FloatTitle:TelescopePreviewTitle",
          },
        },
      })
    end,
  },
  { "stevearc/conform.nvim",           lazy = true,          config = function() require "plugins.configs.conform" end, },
  { "windwp/nvim-ts-autotag",          event = "VeryLazy" },
  { "andymass/vim-matchup",            event = "VeryLazy" },
  { "vim-ruby/vim-ruby",               event = "BufReadPre" },
  { "nvim-pack/nvim-spectre",          cmd = "Spectre" },
  { "tpope/vim-haml",                  event = "VeryLazy" },
  { "ellisonleao/glow.nvim",           config = true,        cmd = "Glow" },
  { "thoughtbot/vim-rspec",            event = "VeryLazy" },
  { "sindrets/diffview.nvim",          event = "VeryLazy" },
  { "vim-test/vim-test",               event = "VeryLazy" },
  { "rhysd/clever-f.vim",              event = "VeryLazy" },
  { "wakatime/vim-wakatime",           lazy = false },
  { "mg979/vim-visual-multi",          event = "VeryLazy",   branch = "master" },
  { "tpope/vim-rails",                 event = "VeryLazy" },
  { "mattn/emmet-vim",                 event = "VeryLazy" },
  { "folke/persistence.nvim",          event = "BufReadPre", opts = {} },
  { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre", config = require("plugins.configs.rainbow") },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config =
        require("plugins.configs.copilot")
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
    event = "BufReadPre",
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
    cmd = "HopWord",
  },
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "declancm/cinnamon.nvim",
    config = function()
      require("cinnamon").setup()
    end,
    event = "VeryLazy",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "BufReadPre",
  },
  {
    "jonahgoldwastaken/copilot-status.nvim",
    dependencies = { "zbirenbaum/copilot.lua" },
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("copilot_status").setup({
        icons = {
          idle = " ",
          error = " ",
          offline = " ",
          warning = " ",
          loading = " ",
        },
        debug = false,
      })
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = require("plugins.configs.gpt"),
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = require("plugins.configs.dashboard"),
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = require("plugins.configs.whichkey")
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = { user_default_options = { names = false } },
  },
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = function()
      require("scope").setup({})
    end
  }
}

require("lazy").setup(plugins, require "plugins.configs.lazy")

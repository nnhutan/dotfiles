local config = {

  -- Set dashboard header
  header = {
    "",
    "",
    "",
    "",
    " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
    " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
    " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
    " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
    " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
    " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
    "",
    "",
    "",
  },
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  -- colorscheme = "default_theme",
  -- colorscheme = "tokyonight",
  --[[ colorscheme = "material", ]]
  colorscheme = "nightfly",
  -- colorscheme = "catppuccin",
  --[[ colorscheme = "duskfox", ]]
  -- colorscheme = "catppuccin",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require "default_theme.colors"

      -- New approach instead of diagnostic_style
      highlights.DiagnosticError.italic = true
      highlights.DiagnosticHint.italic = true
      highlights.DiagnosticInfo.italic = true
      highlights.DiagnosticWarn.italic = true

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
      hlsearch = false,
      wrap = true,
      title = true,
      cmdheight = 1,
      redrawtime = 10000,
      -- shell = "/bin/bash",
      synmaxcol = 128,
      -- foldmethod = "syntax",
      foldlevel = 20,
      foldmethod = "expr",
      foldexpr = "nvim_treesitter#foldexpr()",
      linebreak = true,
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      -- catppuccin_flavour = "macchiato", -- latte, frappe, macchiato, mocha

      --[[ neon_style = "doom", -- default, dark, doom, light ]]
      --[[ neon_italic_keyword = true, ]]
      --[[ neon_italic_function = true, ]]
      -- neon_transparent = true,

      nightflyCursorColor = true,
      nightflyItalics = true,
      nightflyNormalFloat = true,
      nightflyTerminalColors = true,
      -- [[ nightflyTransparent = true, ]]
      nightflyUndercurls = true,
      nightflyUnderlineMatchParen = true,

      --[[ moonlight_italic_comments = true, ]]
      --[[ moonlight_italic_keywords = true, ]]
      --[[ moonlight_italic_functions = true, ]]
      --[[ moonlight_italic_variables = false, ]]

      --[[ moonlight_contrast = true, ]]
      --[[ moonlight_borders = false, ]]
      --[[ moonlight_disable_background = false, ]]

      --[[ material_style = "deep ocean", --palenight, darker, lighter, oceanic, deep ocean ]]

      copilot_filetypes = { ["*"] = true },
      copilot_no_tab_map = true,
      -- copilot_assume_mapped = true,
      -- copilot_tab_fallback = "",
      vimtex_view_method = "zathura",
      vimtex_view_general_viewer = "okular",
      vimtex_view_general_options = "--unique file:@pdf#src:@line@tex",
      vimtex_compiler_method = "latexrun",
    },
    o = {
      lazyredraw = true,
      cmdheight = 1,
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = true,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      --[[ ["nvim-neo-tree/neo-tree.nvim"] = { disable = true }, ]]
      ["feline-nvim/feline.nvi"] = { disable = true },
      -- ["lewis6991/gitsigns.nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      { "junegunn/vim-easy-align" },
      { "tpope/vim-rails" },
      { "preservim/tagbar" },
      { "mattn/emmet-vim" },
      { "github/copilot.vim" },
      { "folke/tokyonight.nvim" },
      { "rafamadriz/neon" },
      { "bluz71/vim-nightfly-guicolors" },
      { "shaunsingh/moonlight.nvim" },
      --[[ { ]]
      --[[   "marko-cerovac/material.nvim", ]]
      --[[   config = function() ]]
      --[[     require("material").setup { ]]
      --[[       italics = { ]]
      --[[         comments = true, -- Enable italic comments ]]
      --[[         keywords = true, -- Enable italic keywords ]]
      --[[         functions = true, -- Enable italic functions ]]
      --[[         strings = true, -- Enable italic strings ]]
      --[[         variables = true, -- Enable italic variables ]]
      --[[       }, ]]
      --[[       lualine_style = "stealth", -- default or stealth ]]
      --[[     } ]]
      --[[   end, ]]
      --[[ }, ]]
      {
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
        config = function()
          -- you can configure Hop the way you like here; see :h hop-config
          require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
        end,
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function() require("lsp_signature").setup() end,
      },
      {
        "kylechui/nvim-surround",
        config = function()
          require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
          }
        end,
      },
      { "arkav/lualine-lsp-progress" },
      {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
      },
      {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
          require("lualine").setup {
            -- options = { theme = "catppuccin" },
            options = { theme = "nightfly" },
            sections = {
              lualine_a = { "mode" },
              lualine_b = { "branch", "diff", "diagnostics" },
              lualine_c = { "filename", "lsp_progress" },
              lualine_x = {
                function()
                  local icon = " "
                  local clients = {}

                  for _, client in pairs(vim.lsp.buf_get_clients(0)) do
                    clients[#clients + 1] = client.name
                  end
                  if #clients == 0 then return " No Active Lsp" end
                  return icon .. table.concat(clients, ", ")
                end,
                "encoding",
                "fileformat",
                "filetype",
              },
              lualine_y = { "progress" },
              lualine_z = { "location" },
            },
          }
        end,
      },

      {
        "EdenEast/nightfox.nvim",
        config = function()
          require("nightfox").setup {
            options = {
              styles = {
                comments = "italic",
                keywords = "italic,bold",
                --[[ types = "italic,bold", ]]
                functions = "italic",
                strings = "italic",
                --[[ variables = "italic", ]]
              },
            },
          }
        end,
      },
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
          require("catppuccin").setup {
            styles = {
              comments = { "italic" },
              conditionals = { "italic" },
              functions = { "italic" },
              keywords = { "italic", "bold" },
              strings = { "italic" },
            },
          }
        end,
      },
      { "mg979/vim-visual-multi" },
      { "lervag/vimtex" },
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.rufo,
        -- null_ls.builtins.formatting.rubocop,
        -- null_ls.builtins.diagnostics.standardrb,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        -- if client.resolved_capabilities.document_formatting then
        if client.server_capabilities.documentFormattingProvider then
          --[[ vim.api.nvim_create_autocmd("BufWritePre", { ]]
          --[[   desc = "Auto format before save", ]]
          --[[   pattern = "<buffer>", ]]
          --[[   callback = vim.lsp.buf.formatting_sync, ]]
          --[[   -- callback = vim.lsp.buf.format, ]]
          --[[ }) ]]
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              -- group = augroup,
              -- buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- vim.lsp.buf.formatting_sync(nil, 2000)
                -- vim.lsp.buf.formatting_sync()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end
        end
      end
      return config -- return final config table
    end,

    treesitter = {
      ensure_installed = "all",
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = {
      ensure_installed = { "sumneko_lua" },
    },
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-tool-installer"] = {
      ensure_installed = { "prettier", "stylua" },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
    toggleterm = {
      --open_mapping = [[<c-t>]]
      --[[ direction = "horizontal", ]]
    },
    session_manager = {
      autosave_last_session = true,
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["copilot"] = {
      autostart = true,
    },

    ["server-settings"] = {
      copilot = {
        autostart = true,
      },
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      ["<leader>bd"] = { "<cmd>bufdo Bwipeout<cr>", desc = "Close all" },
      ["<leader>bp"] = { "<cmd>let @+ = expand('%:p')<cr>", desc = "Copy path" },
      ["<leader>bh"] = { "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
      ["<leader>bl"] = { "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
      --[[ ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", desc = "Toggle explore" }, ]]
      --[[ ["<leader>e"] = { "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle explore" }, ]]
      --[[ ["<leader>o"] = { "<cmd>NvimTreeFocus<cr>", desc = "Focus of explore" }, ]]
      ["<leader>ss"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" },

      ["<leader>ms"] = { "<cmd>MarkdownPreview<cr>", desc = "Start markdown preview" },
      ["<leader>me"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Stop markdown preview" },
      ["<leader>a"] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },
      ["<leader>j"] = { "<cmd>HopWord<cr>", desc = "Jump to word" },
      ["<leader>k"] = { "<cmd>TagbarOpenAutoClose<cr>", desc = "Show tagbar" },
      ["<leader>ll"] = { "<cmd>LspRestart<cr>", desc = "Reload workspace" },
      ["<leader>ee"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle explorer" },
      ["<leader>eb"] = { "<cmd>Neotree buffers<cr>", desc = "Toggle explorer buffers" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      --[[ ["<C-t"] = { "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" }, ]]
    },
    t = {
      -- setting a mapping to false will disable it
      ["<esc>"] = false,
    },
    i = {
      -- ["<C-a>"] = { ":copilot#Accept('\\<CR>')<CR>", silent = true },
      --[[ ["<C-t"] = { "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>" }, ]]
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
          ["m"] = { name = "Markdown" },
          ["r"] = { name = "Align" },
          ["e"] = { name = "Explorer" },
        },
      },
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      desc = "Enable fold",
      group = "packer_conf",
      pattern = "SessionLoadPost",
      command = "set foldmethod=expr | set foldexpr=nvim_treesitter#foldexpr() | set foldlevel=20 | Copilot enable",
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
    vim.cmd "set foldmethod=expr"
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    return {
      polish = function()
        local function alpha_on_bye(cmd)
          local bufs = vim.fn.getbufinfo { buflisted = true }
          vim.cmd(cmd)
          if require("core.utils").is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
        end

        vim.keymap.del("n", "<leader>c")
        if require("core.utils").is_available "bufdelete.nvim" then
          vim.keymap.set("n", "<leader>c", function() alpha_on_bye "Bdelete!" end, { desc = "Close buffer" })
        else
          vim.keymap.set("n", "<leader>c", function() alpha_on_bye "bdelete!" end, { desc = "Close buffer" })
        end
      end,
    }
  end,
}

return config

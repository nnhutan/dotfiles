return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    },
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
      local z_utils = require("telescope._extensions.zoxide.utils")

      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim"
          },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.9,
            height = 0.90,
            preview_cutoff = 120,
          },
          -- file_sorter = require("telescope.sorters").get_fuzzy_file,
          -- file_ignore_patterns = { "node_modules" },
          -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          -- path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").cycle_history_next,
              ["<C-p>"] = require("telescope.actions").cycle_history_prev,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-o>"] = function(prompt_bufnr)
                require("telescope.actions").select_default(prompt_bufnr)
                require("telescope.builtin").resume()
              end,
              ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            },
            n = {
              ["<C-o>"] = function(prompt_bufnr)
                require("telescope.actions").select_default(prompt_bufnr)
                require("telescope.builtin").resume()
              end,
              ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
              ["q"] = require("telescope.actions").close,
            },
          },
        },
        pickers = {
          find_files = {
            mappings = {
              n = {
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  require("telescope.actions").close(prompt_bufnr)
                  -- Depending on what you want put `cd`, `lcd`, `tcd`
                  vim.cmd(string.format("silent lcd %s", dir))
                end
              }
            }
          },
          colorscheme = {
            enable_preview = true
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          aerial = {
            -- Display symbols as <root>.<parent>.<symbol>
            show_nesting = {
              ["_"] = false, -- This key will be the default
              json = true,   -- You can set the option for specific filetypes
              yaml = true,
            },
          },
          zoxide = {
            prompt_title = "Change Directory",
            mappings = {
              default = {
                after_action = function(selection)
                  print("Update to (" .. selection.z_score .. ") " .. selection.path)
                end
              },
              ["<C-s>"] = {
                before_action = function(selection) print("before C-s") end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end
              },
              -- Opens the selected entry in a new split
              ["<C-q>"] = { action = z_utils.create_basic_command("split") },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            } }
        },

      })

      local extensions_list = {
        "fzf",
        -- "projections",
        "aerial",
        'zoxide',
        'ui-select' }
      for _, ext in ipairs(extensions_list) do
        telescope.load_extension(ext)
      end



      local map = vim.keymap.set
      map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
      map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Find words" })
      map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
      map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
      map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
      map("n", "<leader>fN", "<cmd> Telescope notify <CR>", { desc = "Notifications" })
      map("n", "<leader>ft", "<cmd> Telescope colorscheme <CR>", { desc = "Theme" })
      map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
      map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })
      map("n", "<leader>fa", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })
    end
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/popup.nvim',
    }
  },
}

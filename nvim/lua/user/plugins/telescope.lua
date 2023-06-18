return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "nvim-telescope/telescope-media-files.nvim",
  },
  -- the first parameter is the plugin specification
  -- the second is the table of options as set up in Lazy with the `opts` key
  config = function(plugin, opts)
    -- run the core AstroNvim configuration function with the options table
    require("plugins.configs.telescope")(plugin, opts)

    -- require telescope and load extensions as necessary
    local telescope = require "telescope"
    telescope.load_extension "media_files"
  end,
  opts = function()
    local actions = require "telescope.actions"
    local get_icon = require("astronvim.utils").get_icon

    return {
      defaults = {
        prompt_prefix = string.format("%s ", get_icon "Search"),
        selection_caret = string.format("%s ", get_icon "Selected"),
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-o>"] = function(prompt_bufnr)
              require("telescope.actions").select_default(prompt_bufnr)
              require("telescope.builtin").resume()
            end,
            ["<C-q>"] = function(prompt_bufnr)
              actions.send_selected_to_qflist(prompt_bufnr)
              actions.open_qflist(prompt_bufnr)
            end,
          },
          n = {
            ["q"] = actions.close,
            ["<C-o>"] = function(prompt_bufnr)
              require("telescope.actions").select_default(prompt_bufnr)
              require("telescope.builtin").resume()
            end,
            ["<C-q>"] = function(prompt_bufnr)
              actions.send_selected_to_qflist(prompt_bufnr)
              actions.open_qflist(prompt_bufnr)
            end,
          },
        },
      },
    }
  end,
}

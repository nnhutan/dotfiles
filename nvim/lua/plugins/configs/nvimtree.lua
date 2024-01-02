return function(_, opts)
  require("nvim-tree").setup({
    filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true, -- Turn into false from true by default
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      side = "left",
      width = 40,
      preserve_window_proportions = false,
    },
    git = { enable = true, },
    filesystem_watchers = { enable = true, },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      root_folder_label = true,
      highlight_git = true,
      highlight_opened_files = "none",

      indent_markers = {
        enable = false,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  })
end

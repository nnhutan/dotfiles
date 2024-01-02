-- "  𝕟 𝕖 𝕠 𝕧 𝕚 𝕞  "
return function()
  require("dashboard").setup({
    theme = "hyper",
    disable_move = true,
    preview = {
      command = 'echo "\\n\\n\\n" && cat | cat',
      file_path = "~/.config/nvim/lua/logo.cat",
      file_height = 13,
      file_width = 71,
    },
    hide = {
      -- statusline = true,
      tabline = false,
    },
    config = {
      project = {
        enable = true,
        limit = 4,
        action = function(path)
          require("projections.switcher").switch(path)
        end
      },
      mru = { limit = 5 },
      shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          icon_hl = '@variable',
          desc = ' Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Project',
          group = '@character',
          action = 'Telescope projections',
          key = 'p',
        },
        {
          desc = ' Settings',
          group = '@keyword',
          action = 'e ~/.config/nvim/init.lua',
          key = 's',
        },
        {
          desc = ' Quit',
          group = 'Number',
          action = 'qa',
          key = 'q',
        }
      },
      footer = function()
        return {
          "",
          "Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
        }
      end
    }
  })
  vim.cmd([[ hi! link dashboardFooter Text ]])
end

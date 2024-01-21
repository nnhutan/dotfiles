return function()
  local harpoon = require("harpoon")

  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  harpoon:extend({
    UI_CREATE = function(cx)
      vim.keymap.set("n", "<C-v>", function()
        harpoon.ui:select_menu_item({ vsplit = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-x>", function()
        harpoon.ui:select_menu_item({ split = true })
      end, { buffer = cx.bufnr })

      vim.keymap.set("n", "<C-t>", function()
        harpoon.ui:select_menu_item({ tabedit = true })
      end, { buffer = cx.bufnr })
    end,
  })

  vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
  vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


  -- basic telescope configuration
  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    }):find()
  end

  vim.keymap.set("n", "<leader>fm", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })
end

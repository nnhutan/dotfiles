return function()
  require("projections").setup({
    workspaces = { -- Default workspaces to search for
      -- { "~/Documents/dev", { ".git" } },        Documents/dev is a workspace. patterns = { ".git" }
      -- { "~/repos", {} },                        An empty pattern list indicates that all subdirectories are considered projects
      -- "~/.config",
      { "~/dotfiles", {} },
      { "~/work",     {} },
    },
    store_hooks = {
      pre = function()
        -- nvim-tree
        local nvim_tree_present, api = pcall(require, "nvim-tree.api")
        if nvim_tree_present then api.tree.close() end
      end,

      post = function()
        local nvim_tree_present, api = pcall(require, "nvim-tree.api")
        if nvim_tree_present then
          local global_cwd = vim.fn.getcwd(-1, -1)
          api.tree.change_root(global_cwd)
        end
      end,
    },
    -- patterns = { ".git", ".svn", ".hg" },      -- Default patterns to use if none were specified. These are NOT regexps.
    -- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
    restore_hooks = {
      -- pre = function()
      --   vim.fn.timer_start(300, function()
      --     vim.cmd("LspStop")
      --   end)
      -- end,
      post = function()
        if not vim.tbl_isempty(vim.lsp.buf_get_clients()) then
          local timer = vim.loop.new_timer()
          timer:start(
            500,
            100,
            vim.schedule_wrap(function()
              vim.cmd("LspRestart")
              if not timer:is_closing() then
                timer:close()
              end
              vim.cmd([[tabdo e]])
            end))
        end
      end
    },
    -- workspaces_file = "~/dotfiles/nvim/lua/workspaces.json",
    sessions_directory = "~/.local/state/nvim/sessions",

  })



  vim.keymap.set("n", "<leader><leader>", function() vim.cmd("Telescope projections") end)

  -- Autostore session on VimExit
  local Session = require("projections.session")
  vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    callback = function() Session.store(vim.loop.cwd()) end,
  })

  -- Switch to project if vim was started in a project dir
  local switcher = require("projections.switcher")
  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
    end,
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        -- When in diff mode, we want to use the default
        -- vim text objects c & C instead of the treesitter ones.
        local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
        local cons = require("nvim-treesitter.configs")
        for name, fn in pairs(move) do
          if name:find("goto") == 1 then
            move[name] = function(q, ...)
              if vim.wo.diff then
                local config = cons.get_module("textobjects.move")[name] ---@type table<string,string>
                for key, query in pairs(config or {}) do
                  if q == query and key:find("[%]%[][cC]") then
                    vim.cmd("normal! " .. key)
                    return
                  end
                end
              end
              return fn(q, ...)
            end
          end
        end
      end,
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        require 'treesitter-context'.setup {
          enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20,     -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
        vim.cmd [[
          hi TreesitterContextBottom gui=NONE guisp=Grey
          hi TreesitterContextLineNumberBottom gui=NONE guisp=Grey
        ]]
      end,
    }
  },
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
    require("lazy.core.loader").add_to_rtp(plugin)
    require "nvim-treesitter.query_predicates"
  end,
  config =
      function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "lua", "vim", "vimdoc", "tsx", "html", "css", "typescript", "javascript" },
          indent = { enable = true },
          incremental_selection = { enable = true },
          matchup = { enable = true,
            disable = { "haml" }, -- optional, list of language that will be disabled
          },
          highlight = {
            enable = true,
            -- additional_vim_regex_highlighting = false,
            additional_vim_regex_highlighting = { 'ruby' },
            disable = function(_, bufnr)
              if vim.bo.filetype == "help" then
                return true
              elseif vim.bo.filetype == "lua" then
                return true
                -- elseif vim.bo.filetype == "haml" then
                --   return true
              else
                local buf_name = vim.api.nvim_buf_get_name(bufnr)
                local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
                return file_size > 256 * 1024
              end
            end,
          },
        }
      end
}

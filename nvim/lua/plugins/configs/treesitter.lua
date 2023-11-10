return function()
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "vim", "vimdoc", "tsx", "html", "css", "typescript", "javascript" },
    indent = { enable = true },
    incremental_selection = { enable = true },
    autotag = { enable = true, },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(_, bufnr)
        if vim.bo.filetype == "help" then
          return true
        elseif vim.bo.filetype == "lua" then
          return true
        else
          local buf_name = vim.api.nvim_buf_get_name(bufnr)
          local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
          return file_size > 256 * 1024
        end
      end,
    },

  }
end

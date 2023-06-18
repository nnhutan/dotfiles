-- LunarVim keymaps
local cmp = require "cmp"
lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end

-- local map = vim.api.nvim_set_keymap
-- local default_opts = {noremap = true, silent = true}

-- -- Use escape to leave insert mode in terminal
-- map('t', '<Esc>', '<C-\\><C-n>', default_opts)
-- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], { noremap = true })
-- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], { noremap = true })
-- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], { noremap = true })
-- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], { noremap = true })
-- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], { noremap = true })
-- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], { noremap = true })

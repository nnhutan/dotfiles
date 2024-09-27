return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  enabled = false,
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", },
  config = function()
    require("chatgpt").setup({
      api_key_cmd = nil,
      yank_register = "+",
      edit_with_instructions = {
        diff = true,
        keymaps = {
          close = "<C-c>",
          accept = "<C-y>",
          toggle_diff = "<C-d>",
          toggle_settings = "<C-o>",
          cycle_windows = "<Tab>",
          use_output_as_input = "<C-i>",
        },
      },
      chat = {
        border_left_sign = "",
        border_right_sign = "",
        sessions_window = {
          active_sign = "  ",
          inactive_sign = "  ",
          current_line_sign = "󰁕",
          border = {
            highlight = "TelescopePreviewBorder",
            text = {
              top = { { ' Parameters ', 'TelescopeResultTitle' } },
            },
          },
          win_options = {
            winhighlight = "Normal:TelescopePreviewBorder,FloatBorder:TelescopePromptNormal",
            statuscolumn =
            '%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "-" : "+") : "│") : " " }'
          },

        },
        keymaps = {
          close = "<C-c>",
          yank_last = "<C-y>",
          yank_last_code = "<C-k>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
          cycle_modes = "<C-f>",
          next_message = "<C-j>",
          prev_message = "<C-k>",
          select_session = "<CR>",
          rename_session = "r",
          delete_session = "d",
          draft_message = "<C-d>",
          edit_message = "e",
          delete_message = "d",
          toggle_settings = "<C-o>",
          toggle_message_role = "<C-r>",
          toggle_system_role_open = "<C-s>",
          stop_generating = "<C-x>",
        },
      },
      popup_window = {
        border = {
          highlight = "TelescopePreviewBorder",
        },
        win_options = {
          wrap = true,
          linebreak = true,
          -- foldcolumn = "1",
          winhighlight = "Normal:TelescopePreviewNormal,FloatBorder:FloatBorder",
          statuscolumn =
          '%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "-" : "+") : "│") : " " }'
        },
        buf_options = {
          filetype = "markdown",
        },
      },
      system_window = {
        border = {
          highlight = "TelescopePromptBorder",
        },
        win_options = {
          wrap = true,
          linebreak = true,
          -- foldcolumn = "2",
          winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
          statuscolumn =
          '%=%l%s%{foldlevel(v:lnum) > 0 ? (foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "-" : "+") : "│") : " " }'
        },
      },
      popup_layout = {
        default = "center",
        center = {
          width = "90%",
          height = "90%",
        },
      },
      popup_input = {
        prompt = "  ",
        border = {
          highlight = "TelescopePromptBorder",
        },
        win_options = {
          winhighlight = "Normal:TelescopePromptNormal,FloatBorder:FloatBorder",
        },
        submit = "<C-Enter>",
        submit_n = "<Enter>",
        max_visible_lines = 20,
      },
      help_window = {
        border = {
          highlight = "TelescopePreviewBorder",
          text = {
            top = { { ' Parameters ', 'TelescopeResultTitle' } },
          },

        },
        win_options = {
          winhighlight = "Normal:TelescopePreviewBorder,FloatBorder:TelescopePromptNormal",
        },
      },
      settings_window = {
        border = {
          highlight = "TelescopePreviewBorder",
          text = {
            top = { { ' Parameters ', 'TelescopeResultTitle' } },
          },
        },
        win_options = {
          winhighlight = "Normal:TelescopePreviewBorder,FloatBorder:TelescopePromptNormal",
        },
      },
    })

    -- local map = vim.keymap.set
    -- map("n", "<leader>G", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
    -- map("n", "<leader>kc", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
    -- map("n", "<leader>ke", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
    -- map("n", "<leader>kg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
    -- map("n", "<leader>kt", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
    -- map("n", "<leader>kk", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
    -- map("n", "<leader>kd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
    -- map("n", "<leader>ka", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
    -- map("n", "<leader>ko", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
    -- map("n", "<leader>ks", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
    -- map("n", "<leader>kf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
    -- map("n", "<leader>kx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
    -- map("n", "<leader>kr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
    -- map("n", "<leader>kl", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })
    -- map("n", "<leader>G", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
    -- map("n", "<leader>kc", "<cmd>ChatGPT<CR>", { desc = "ChatGPT" })
    -- map("n", "<leader>ke", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
    -- map("n", "<leader>kg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
    -- map("n", "<leader>kt", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
    -- map("n", "<leader>kk", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
    -- map("n", "<leader>kd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
    -- map("n", "<leader>ka", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
    -- map("n", "<leader>ko", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
    -- map("n", "<leader>ks", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
    -- map("n", "<leader>kf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
    -- map("n", "<leader>kx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
    -- map("n", "<leader>kr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
    -- map("n", "<leader>kl", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })
    -- map("v", "<leader>ke", "<cmd>ChatGPTEditWithInstruction<CR>", { desc = "Edit with instruction" })
    -- map("v", "<leader>kg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar Correction" })
    -- map("v", "<leader>kt", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
    -- map("v", "<leader>kk", "<cmd>ChatGPTRun keywords<CR>", { desc = "Keywords" })
    -- map("v", "<leader>kd", "<cmd>ChatGPTRun docstring<CR>", { desc = "Docstring" })
    -- map("v", "<leader>ka", "<cmd>ChatGPTRun add_tests<CR>", { desc = "Add Tests" })
    -- map("v", "<leader>ko", "<cmd>ChatGPTRun optimize_code<CR>", { desc = "Optimize Code" })
    -- map("v", "<leader>ks", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
    -- map("v", "<leader>kf", "<cmd>ChatGPTRun fix_bugs<CR>", { desc = "Fix Bugs" })
    -- map("v", "<leader>kx", "<cmd>ChatGPTRun explain_code<CR>", { desc = "Explain Code" })
    -- map("v", "<leader>kr", "<cmd>ChatGPTRun roxygen_edit<CR>", { desc = "Roxygen Edit" })
    -- map("v", "<leader>kl", "<cmd>ChatGPTRun code_readability_analysis<CR>", { desc = "Code Readability Analysis" })
  end
}

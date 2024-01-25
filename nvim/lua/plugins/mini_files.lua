local my_prefix = function(fs_entry)
  if fs_entry.fs_type == 'directory' then
    -- NOTE: it is usually a good idea to use icon followed by space
    return ' ', 'MiniFilesDirectory'
  end
  local icon, hl = MiniFiles.default_prefix(fs_entry)
  if icon == ' ' and hl == 'MiniFilesFile' then
    return '󰈚 ', 'MiniFilesFile'
  end
  return icon, hl
end



return {
  'echasnovski/mini.files',
  version = '*',
  config =
      function()
        require('mini.files').setup(
        -- No need to copy this inside `setup()`. Will be used automatically.
          {
            -- Customization of shown content
            content = {
              -- Predicate for which file system entries to show
              filter = nil,
              -- What prefix to show to the left of file system entry
              prefix = my_prefix,
              -- In which order to show file system entries
              sort = nil,
            },

            -- Module mappings created only inside explorer.
            -- Use `''` (empty string) to not create one.
            mappings = {
              close       = 'q',
              go_in       = 'L',
              go_in_plus  = '<c-l>',
              go_out      = 'H',
              go_out_plus = '<c-h>',
              reset       = '<BS>',
              reveal_cwd  = '@',
              show_help   = 'g?',
              synchronize = '=',
              trim_left   = '<',
              trim_right  = '>',
            },

            -- General options
            options = {
              -- Whether to delete permanently or move into module-specific trash
              permanent_delete = false,
              -- Whether to use for editing directories
              use_as_default_explorer = true,
            },

            -- Customization of explorer windows
            windows = {
              -- Maximum number of windows to show side by side
              max_number = math.huge,
              -- Whether to show preview of file/directory under cursor
              preview = false,
              -- Width of focused window
              width_focus = 50,
              -- Width of non-focused window
              width_nofocus = 25,
              -- Width of preview window
              width_preview = 120,
            },
          }
        )


        vim.keymap.set('n', '<leader>e',
          function(...)
            if not MiniFiles.close() then MiniFiles.open(...) end
          end, { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>o',
          function(...)
            if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
          end, { noremap = true, silent = true })

        local map_split = function(buf_id, lhs, direction)
          local rhs = function()
            -- Make new window and set it as target
            local new_target_window
            vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
              vim.cmd(direction .. ' split')
              new_target_window = vim.api.nvim_get_current_win()
            end)

            MiniFiles.set_target_window(new_target_window)
          end

          -- Adding `desc` will result into `show_help` entries
          local desc = 'Split ' .. direction
          vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
        end

        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniFilesBufferCreate',
          callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak keys to your liking
            map_split(buf_id, 'gx', 'belowright horizontal')
            map_split(buf_id, 'gv', 'belowright vertical')
            vim.keymap.set('n', 'gt', function()
              local file = MiniFiles.get_fs_entry().path
              vim.cmd('tabedit ' .. file)
            end, { buffer = buf_id, desc = 'Open on new tab' })
          end,
        })

        local files_set_cwd = function(path)
          -- Works only if cursor is on the valid file system entry
          local cur_entry_path = MiniFiles.get_fs_entry().path
          local cur_directory = vim.fs.dirname(cur_entry_path)
          vim.fn.chdir(cur_directory)
        end

        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniFilesBufferCreate',
          callback = function(args)
            vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })
          end,
        })

        local show_dotfiles = true

        local filter_show = function(fs_entry) return true end

        local filter_hide = function(fs_entry)
          return not vim.startswith(fs_entry.name, '.')
        end

        local toggle_dotfiles = function()
          show_dotfiles = not show_dotfiles
          local new_filter = show_dotfiles and filter_show or filter_hide
          MiniFiles.refresh({ content = { filter = new_filter } })
        end

        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniFilesBufferCreate',
          callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak left-hand side of mapping to your liking
            vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
          end,
        })

        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniFilesBufferCreate',
          callback = function(args)
            vim.keymap.set('n', '<CR>', function()
              local fs_entry = MiniFiles.get_fs_entry()
              MiniFiles.go_in()

              if fs_entry.fs_type == 'file' then
                MiniFiles.close()
              end
            end, { buffer = args.data.buf_id })
          end,
        })
      end
}

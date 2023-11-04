local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_keymap = function(values)
  local default_opts = { mode = mode }
  for mode, mode_values in pairs(values) do
    for keybind, mapping_info in pairs(mode_values) do
      local opts = merge_tb("force", default_opts, mapping_info.opts or {})
      opts.silent = opts.silent ~= false
      opts.desc = mapping_info[2]

      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

function M.FuzzyFindFiles()
  local input_string = vim.fn.input("Search For > ")
  if input_string == "" then
    return
  end
  require("telescope.builtin").grep_string({ search = input_string })
end

function M.CopyFilePath(type)
  local filepath = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")
  local modify = vim.fn.fnamemodify

  local results = {
    e = { val = modify(filename, ":e"), msg = "Extension only" },
    f = { val = filename, msg = "Filename" },
    F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
    h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
    p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
    P = { val = filepath, msg = "Absolute path" },
  }

  local result = results[type]
  if result and result.val and result.val ~= "" then
    vim.notify("Copied: " .. result.val)
    vim.fn.setreg("+", result.val)
  end
end

function M.foldtext()
  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()
  if not ret or type(ret) == "string" then
    ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
  end
  table.insert(ret, { " " .. "󰇘" })

  if not vim.treesitter.foldtext then
    return table.concat(
      vim.tbl_map(function(line)
        return line[1]
      end, ret),
      " "
    )
  end
  return ret
end

function M.get_signs(buf, lnum)
  local signs = vim.tbl_map(function(sign)
    local ret = vim.fn.sign_getdefined(sign.name)[1]
    ret.priority = sign.priority
    return ret
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs)

  -- Get extmark signs
  local extmarks = vim.api.nvim_buf_get_extmarks(
    buf,
    -1,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { details = true, type = "sign" }
  )
  for _, extmark in pairs(extmarks) do
    signs[#signs + 1] = {
      name = extmark[4].sign_hl_group or "",
      text = extmark[4].sign_text,
      texthl = extmark[4].sign_hl_group,
      priority = extmark[4].priority,
    }
  end

  -- Sort by priority
  table.sort(signs, function(a, b)
    return (a.priority or 0) < (b.priority or 0)
  end)

  return signs
end

function M.get_mark(buf, lnum)
  local marks = vim.fn.getmarklist(buf)
  vim.list_extend(marks, vim.fn.getmarklist())
  for _, mark in ipairs(marks) do
    if mark.pos[1] == buf and mark.pos[2] == lnum and mark.mark:match("[a-zA-Z]") then
      return { text = mark.mark:sub(2), texthl = "DiagnosticHint" }
    end
  end
end

function M.icon(sign, len)
  sign = sign or {}
  len = len or 2
  local text = vim.fn.strcharpart(sign.text or "", 0, len) ---@type string
  text = text .. string.rep(" ", len - vim.fn.strchars(text))
  return sign.texthl and ("%#" .. sign.texthl .. "#" .. text .. "%*") or text
end

function M.statuscolumn()
  local win = vim.g.statusline_winid
  local buf = vim.api.nvim_win_get_buf(win)
  local is_file = vim.bo[buf].buftype == ""
  local show_signs = vim.wo[win].signcolumn ~= "no"

  local components = { "", "", "" } -- left, middle, right

  if show_signs then
    local left, right, fold
    for _, s in ipairs(M.get_signs(buf, vim.v.lnum)) do
      if s.name and s.name:find("GitSign") then
        right = s
      else
        left = s
      end
    end
    if vim.v.virtnum ~= 0 then
      left = nil
    end
    vim.api.nvim_win_call(win, function()
      if vim.fn.foldclosed(vim.v.lnum) >= 0 then
        fold = { text = vim.opt.fillchars:get().foldclose or "", texthl = "Folded" }
      end
    end)
    -- Left: mark or non-git sign
    components[1] = M.icon(M.get_mark(buf, vim.v.lnum) or left)
    -- Right: fold icon or git sign (only if file)
    components[3] = is_file and M.icon(fold or right) or ""
  end

  -- Numbers in Neovim are weird
  -- They show when either number or relativenumber is true
  local is_num = vim.wo[win].number
  local is_relnum = vim.wo[win].relativenumber
  if (is_num or is_relnum) and vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      components[2] = is_num and "%l" or "%r"    -- the current line
    else
      components[2] = is_relnum and "%r" or "%l" -- other lines
    end
    components[2] = "%=" .. components[2] .. " " -- right align
  end

  return table.concat(components, "")
end

function M.getVimVisualMultiStatusLine()
  if vim.b["visual_multi"] then
    local result = vim.fn["VMInfos"]()
    -- local current = result.current
    -- local total = result.total
    local ratio = result.ratio
    local patterns = result.patterns
    -- local status = result.status
    return "%#St_InsertMode# "
        .. " MULTI "
        .. "%#St_lspWarning#  "
        .. patterns[1]
        .. " "
        .. "%#StText#"
        .. " "
        .. ratio
  else
    return ""
  end
end

function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local hl
    if vim.api.nvim_get_hl then -- check for new neovim 0.9 API
      hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      if not hl.fg then hl.fg = "NONE" end
      if not hl.bg then hl.bg = "NONE" end
    else
      hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
      if not hl.foreground then hl.foreground = "NONE" end
      if not hl.background then hl.background = "NONE" end
      hl.fg, hl.bg = hl.foreground, hl.background
      hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
      hl.sp = hl.special
    end
    return hl
  end
  return fallback or {}
end

return M

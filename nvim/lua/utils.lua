local M = {}
local merge_tb = vim.tbl_deep_extend

-- Get from alot of sources: LazyVim, Astronvim, Nvchad, etc. Thanks!

M.load_keymap = function(values)
  for mode, mode_values in pairs(values) do
    for keybind, mapping_info in pairs(mode_values) do
      local opts = mapping_info.opts or {}
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

function M.get_signs(buf, lnum)
  local signs = {}

  if vim.fn.has("nvim-0.10") == 0 then
    -- Only needed for Neovim <0.10
    -- Newer versions include legacy signs in nvim_buf_get_extmarks
    for _, sign in ipairs(vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs) do
      local ret = vim.fn.sign_getdefined(sign.name)[1] --[[@as Sign]]
      if ret then
        ret.priority = sign.priority
        signs[#signs + 1] = ret
      end
    end
  end

  -- local signs = vim.tbl_map(function(sign)
  --   local ret = vim.fn.sign_getdefined(sign.name)[1]
  --   if ret ~= nil then
  --     ret.priority = sign.priority
  --     return ret
  --   end
  -- end, vim.fn.sign_getplaced(buf, { group = "*", lnum = lnum })[1].signs)

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
        fold = { text = "", texthl = "Folded" }
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

function M.LSP_on_attach(client, bufnr)
  local map = vim.keymap.set

  if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
    local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
    if type(bufnr) == "function" then
      ih(bufnr, true)
    elseif type(ih) == "table" and ih.enable then
      ih.enable(bufnr, true)
    end
  end

  local opts = { buffer = bufnr }
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  map("n", "<space>D", vim.lsp.buf.type_definition, opts)
  map("n", "<space>lr", vim.lsp.buf.rename, opts)
  map({ "n", "v" }, "<space>la", vim.lsp.buf.code_action, opts)
  map("n", "gr", vim.lsp.buf.references, opts)

  if not client.supports_method("textDocument/semanticTokens") then client.server_capabilities.semanticTokensProvider = nil end
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "CursorHold", "InsertLeave", "TextChanged" }, {
    buffer = bufnr,
    callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
        if err then return end
        if not result then return end

        vim.lsp.diagnostic.on_publish_diagnostics(nil, vim.tbl_extend("keep", params, { diagnostics = result.items }),
          { client_id = client.id })
      end)
    end,
  })

  vim.cmd([[ hi! link FloatBorder TelescopePreviewBorder ]])
end

function M.LSP_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
  )

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }
  return capabilities
end

function M.LSP_get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

function M.LSP_disable(server, cond)
  local util = require("lspconfig.util")
  local def = M.LSP_get_config(server)
  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config,
    function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end)
end

function M.toggle_theme()
  local flvr = require("catppuccin").flavour or vim.g.catppuccin_flavour or "frappe"
  if flvr ~= "latte" then
    vim.cmd("colorscheme catppuccin-latte")
  else
    vim.cmd("colorscheme catppuccin-frappe")
  end
end

function M.close_all_buffers()
  local bufferline = require("bufferline")
  local tabpages = vim.api.nvim_list_tabpages()
  if #tabpages > 1 then
    vim.cmd("q")
  else
    for _, e in ipairs(bufferline.get_elements().elements) do
      vim.schedule(function()
        vim.cmd("bd " .. e.id)
      end)
    end
  end
end

return M

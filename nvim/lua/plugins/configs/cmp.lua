local M = {}
local icons = require('icons').kinds

M.dependencies = {
  -- cmp sources
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lua",

  -- snippets
  --list of default snippets
  "rafamadriz/friendly-snippets",

  -- snippets engine
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- autopairs , autocompletes ()[] etc
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()

      --  cmp integration
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}

M.config = function()
  local cmp = require "cmp"

  cmp.setup({
    formatting = {
      fields = { "abbr", "kind", "menu" },

      format = function(_, item)
        local icon = icons[item.kind] or ""
        icon = (" " .. icon .. " ")
        item.kind = string.format("%s %s", icon, item.kind or "")
        return item
      end,
    },
    window = {
      completion = {
        side_padding = 1,
        -- winhighlight = "Normal:TelescopePreviewNormal,CursorLine:CmpSel,Search:PmenuSel",
        scrollbar = false,
      },
      documentation = {
        -- winhighlight = "Normal:CmpDoc",
      },
    },

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },

    mapping = cmp.mapping.preset.insert {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },


      -- luasnip
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif require("luasnip").jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    sources = cmp.config.sources {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
    },
  })
end

return M

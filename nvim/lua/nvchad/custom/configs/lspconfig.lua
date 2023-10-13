local utils = require("core.utils")
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
	require("plugins.configs.lspconfig").on_attach(client, bufnr)
	client.server_capabilities.documentFormattingProvider = true
	client.server_capabilities.documentRangeFormattingProvider = true

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre", "CursorHold", "InsertLeave", "TextChanged" }, {
		buffer = bufnr,

		callback = function()
			local params = vim.lsp.util.make_text_document_params(bufnr)

			client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
				if err then
					return
				end

				if not result then
					return
				end

				vim.lsp.diagnostic.on_publish_diagnostics(
					nil,
					vim.tbl_extend("keep", params, { diagnostics = result.items }),
					{ client_id = client.id }
				)
			end)
		end,
	})
end

local cwd = vim.loop.cwd()
local dedault_configures = { on_attach = on_attach, capabilities = capabilities }
local servers = {
	html = {},
	cssls = {},
	clangd = {},
	marksman = {},
	spectral = {},
	gopls = {},
	emmet_ls = {},
	solargraph = { only = { "/Users/lixibox/work/lixibox" } },
	ruby_ls = { ignore = { "/Users/lixibox/work/lixibox" } },
	tsserver = { others = { init_options = { preferences = { quotePreference = "single" } } } },
}

for lsp, config in pairs(servers) do
	if config.ignore then
		local ignore = config.ignore

		if type(ignore) == "string" then
			ignore = { ignore }
		end

		for _, path in ipairs(ignore) do
			if cwd == path then
				goto continue
			end
		end
	end

	if config.only then
		local only = config.only

		if type(only) == "string" then
			only = { only }
		end

		local found = false
		for _, path in ipairs(only) do
			if cwd == path then
				found = true
				break
			end
		end
		if not found then
			goto continue
		end
	end

	local configure = dedault_configures
	if config.others then
		configure = vim.tbl_extend("keep", configure, config.others)
	end

	lspconfig[lsp].setup(configure)
	::continue::
end

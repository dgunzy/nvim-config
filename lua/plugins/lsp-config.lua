return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"gopls",
					"yamlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",

		config = function()
			-- Configure diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				-- Disable the whitespace warnings
				diagnostic_config = {
					whitespace = false,
					trailing_whitespace = false,
				},
			})
			local lspconfig = require("lspconfig")
			-- Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "empty-line" },
						},
						format = {
							enable = true,
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			})
			-- Go
			lspconfig.gopls.setup({})
			-- Python
			lspconfig.pyright.setup({
				capabilities = {
					documentFormattingProvider = true, -- Enable formatting
				},
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})
			-- Shell
			lspconfig.bashls.setup({})
			-- Yaml
			lspconfig.yamlls.setup({})

			-- Keymaps
			vim.keymap.set("n", "G", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "I", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "R", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "C", vim.lsp.buf.code_action, {})
		end,
	},
}

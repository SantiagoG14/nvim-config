local lsp_zero = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, { buffer = bufnr })
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, {})
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)

end)

-- set up language server
mason.setup({})
mason_lspconfig.setup({
	ensure_installed = { "tsserver", "rust_analyzer", "tailwindcss", "lua_ls" },
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,

		rust_analyzer = function()
			require("lspconfig").rust_analyzer.setup({
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable()
				end,
			})
		end,
	},
})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

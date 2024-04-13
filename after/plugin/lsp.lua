local lsp_zero = require("lsp-zero")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {buffer = bufnr})

end)

-- set up language server
mason.setup({})
mason_lspconfig.setup({
	ensure_installed = {'tsserver', 'eslint', 'tailwindcss', 'lua_ls'},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
})

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-y>'] = cmp.mapping.confirm({select = true}),
		['<C-Space>'] = cmp.mapping.complete()
	})
})

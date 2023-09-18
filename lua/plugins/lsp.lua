return {
	{
		'neovim/nvim-lspconfig',
		init=function()
			local lspconfig = require'lspconfig'
			lspconfig.asm_lsp.setup{}
			lspconfig.awk_ls.setup{}
			lspconfig.clangd.setup{}
			lspconfig.cssls.setup{}
			-- lspconfig.ltex.setup{settings={ltex={language='en_US'}}}
			lspconfig.lua_ls.setup{
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT',
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { 'vim' },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file('', true),
							checkThirdParty = false
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = { enable = false, },
					},
				}
			}
			-- lspconfig.marksman.setup{filetype={'markdown', 'vimwiki.markdown'}}
			-- lspconfig.proselint.setup{}
			lspconfig.pylsp.setup{}
			lspconfig.pyright.setup{}
			lspconfig.rust_analyzer.setup{}
			-- lspconfig.textlint.setup{}
			lspconfig.tsserver.setup{}
			lspconfig.vuels.setup{}

		end,
		config=function()
			vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, {desc='diagnostics cur line'})
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc='diagnostics'})
			vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition,{desc='definition'})
			vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation,{desc='implementation'})
			vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition,{desc='type definition'})
			vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {desc='display info about symbol'})
			vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, {desc='implementation'})
			vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {desc='rename'})
			vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, {desc='references'})
			vim.keymap.set('n', '<leader>lf', function()
				vim.lsp.buf.format { async = true }
			end, {desc='format'})
		end,
		dependencies={'williamboman/mason-lspconfig.nvim', 'williamboman/mason.nvim', }
	},
	{
		'williamboman/mason-lspconfig.nvim',
		init=function()
			require'mason-lspconfig'.setup{}
		end,
		dependencies={'williamboman/mason.nvim'}
	},
	{
		'weilbith/nvim-code-action-menu',
		config=function()
			vim.keymap.set(
			'n',
			'<leader>la',
			require'code_action_menu'.open_code_action_menu,
			{desc='code actions'}
			)
		end
	},
}

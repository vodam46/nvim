return {
		'neovim/nvim-lspconfig',
		init=function()
			local lspconfig = require'lspconfig'
			lspconfig.pyright.setup {}
			lspconfig.clangd.setup {}
			lspconfig.lua_ls.setup {
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
						telemetry = {
							enable = false,
						},
					},
				}
			}
			-- lspconfig.marksman.setup{}
			-- lspconfig.asm_lsp.setup{}
		end,
		config=function()
			vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, {desc='diagnostics cur line'})
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc='diagnostics'})

			-- Enable completion triggered by <c-x><c-o>
			-- vim.bo[env.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
			-- Buffer local mappings.
			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			-- local opts = { buffer = env.buf }
			vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition,{desc='definition'})
			vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {desc='display info about symbol'})
			vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, {desc='implementation'})
			vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {desc='rename'})
			-- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
			vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, {desc='references'})
			vim.keymap.set('n', '<leader>lf', function()
				vim.lsp.buf.format { async = true }
			end, {desc='format'})
		end
	}

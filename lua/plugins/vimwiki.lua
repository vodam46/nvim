return {{
		'vimwiki/vimwiki',
		init=function()
			vim.g.vimwiki_list = { {
				path = '/home/vodam/data/ZALOHY/writing',
				template_path = '/home/vodam/data/ZALOHY/writing/templates/',
				template_default = 'default',
				path_html = '/home/vodam/data/ZALOHY/writing/html',
				syntax = 'markdown',
				ext = '.md',
				custom_wiki2html = 'vimwiki_markdown',
				template_ext = '.html'
			} }
			-- vim.g.vimwiki_filetypes={ 'markdown' }
			vim.g.vimwiki_global_ext = 0
			vim.g.vimwiki_folding = 'expr'
			vim.g.vimwiki_auto_chdir = 1
			vim.api.nvim_create_autocmd({ 'BufEnter' }, { pattern = { 'diary.md' }, command = 'VimwikiDiaryGenerateLinks' })
			vim.api.nvim_create_autocmd({ 'BufEnter' }, { pattern = { '*.md' }, command = '%folddoclosed foldopen!' })
		end
	},
	{
		'michal-h21/vim-zettel',
		config=function()
			vim.g.zettel_fzf_command = 1
			vim.g.zettel_options = { { front_matter = { { 'tags', '' }, { 'type', 'note' } } } }
			vim.g.zettel_format = '/zettel/%y%m%d-%H%M-%title'
			vim.keymap.set('n', '<leader>wz', ':tabnew<cr>:ZettelNew<cr>', { noremap = true })
		end
	}}
